class Documents::OfficialMailStateMachine
  include Statesman::Machine

  state :unsaved, initial: true
  state :draft
  state :prepared
  state :approved
  state :sent
  state :trashed

  transition from: :unsaved,  to: [:draft, :prepared]
  transition from: :draft,    to: [:draft, :prepared, :trashed]
  transition from: :prepared, to: [:approved, :draft, :prepared, :trashed]
  transition from: :approved, to: [:sent]

  guard_transition to: :trashed do |mail|
    !mail.new_record?
  end

    after_transition(to: :approved) do |accountable, transition|
    Documents::Accounter.sign(accountable)
  end

  # there should be much recipients
  before_transition(to: :approved) do |accountable, transition|
    if accountable.recipients.any?
      ActiveRecord::Base.transaction do
        # use original record as a valuable container too
        first_recipient = accountable.recipients.first
        accountable.recipients.delete(first_recipient)
        accountable.recipient_organization = first_recipient

        # then duplicate all others
        accountable.recipients.map do |recipient|

          dup = accountable.amoeba_dup
          dup.recipient_organization = recipient
          dup.save!

          Documents::Accounter.sign(dup)
        end
        accountable.recipients.delete_all
        accountable.save!
        true
      end
    end
  end
end
