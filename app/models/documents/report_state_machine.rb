module Documents
  class ReportStateMachine
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
    transition from: :draft,    to: [:draft, :prepared]
    transition from: :prepared, to: [:approved, :draft, :prepared, :trashed]
    transition from: :approved, to: [:sent, :trashed]
    transition from: :sent,     to: [:accepted, :rejected]

    guard_transition to: :approved do |accountable|
      accountable.approvable?
    end

    after_transition(to: :approved) do |accountable, transition|
      Documents::Accounter.sign(accountable)
    end

    # TODO: @prikha remove this guards and references from
    # /app/models/documents/order_state_machine.rb

    after_transition(to: :accepted) do |report, transition|
      report.order.transition_to!(:accepted, transition.metadata)
    end

    after_transition(to: :rejected) do |report, transition|
      report.order.transition_to!(:rejected, transition.metadata)
    end
  end
end
