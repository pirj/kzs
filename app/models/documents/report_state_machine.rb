class Documents::ReportStateMachine
  include Statesman::Machine

  state :unsaved, initial: true
  state :draft
  state :prepared
  state :approved
  state :sent
  state :read
  state :accepted
  state :rejected
  state :trashed

  transition from: :unsaved,  to: [:draft, :prepared, :trashed]
  transition from: :draft,    to: [:draft, :prepared, :trashed]
  transition from: :prepared, to: [:approved, :draft, :prepared, :trashed]
  transition from: :sent,     to: [:read, :trashed]
  transition from: :read,     to: [:accepted, :rejected, :trashed]

  after_transition(to: :accepted) do |accountable, transition|
    Documents::Accounter.sign(accountable)
  end
end
