class Documents::OfficialMailStateMachine
  include Statesman::Machine
  include Documents::StateMachine

  state :unsaved, initial: true
  state :draft
  state :prepared
  state :approved
  state :sent
  state :read
  state :trashed

  transition from: :unsaved, to: [:draft, :prepared, :trashed]
  transition from: :draft, to: [:prepared, :trashed]
  transition from: :prepared, to: [:approved, :trashed]
  transition from: :approved, to: [:sent, :trashed]
  transition from: :sent, to: [:read, :trashed]
  transition from: :read, to: [:trashed]

  after_transition(to: :approved) do |accountable, transition|
    Documents::Accounter.sign(accountable)
  end

  #there should be much recipients
  before_transition(to: :approved) do |accountable, transition|
    ActiveRecord::Base.transaction do
      #use original record as a valuable container too
      accountable.recipient_organization = accountable.recipients.delete(accountable.recipients.first).first

      #then duplicate all others
      accountable.recipients.map do |recipient|

        dup = accountable.amoeba_dup
        dup.recipient_organization = recipient
        dup.save!


        dup.transition_to!(:approved) #for all others go transition to :approved
      end
      accountable.recipients.delete_all
    end
  end



end