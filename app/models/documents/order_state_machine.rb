module Documents
  class OrderStateMachine
    include Statesman::Machine

    state :unsaved, initial: true
    state :draft
    state :prepared
    state :approved
    state :sent
    state :accepted
    state :rejected
    state :trashed

    transition from: :unsaved,  to: [:draft, :prepared]
    transition from: :draft,    to: [:draft, :prepared, :trashed]
    transition from: :prepared, to: [:approved, :draft, :prepared, :trashed]
    transition from: :approved, to: [:sent]
    transition from: :sent,     to: [:accepted, :rejected]

    after_transition(to: :approved) do |accountable, transition|
      Documents::Accounter.sign(accountable)
    end

    # The following guards are for the purpose of cross-validation
    # check that none of the Ordres would be accepted or rejceted
    # until they have matching report
    guard_transition(to: :accepted) do |order|
      Documents::Report.where(order_id: order.id).with_state(guarded).count > 0
    end

    guard_transition(to: :rejected) do |order|
      Documents::Report.where(order_id: order.id).with_state(guarded).count > 0
    end

    def self.guarded
      %w(sent accepted rejected)
    end
  end
end
