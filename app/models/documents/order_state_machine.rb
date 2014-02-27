class Documents::OrderStateMachine
  include Statesman::Machine

  state :unsaved, initial: true
  state :draft
  state :prepared
  state :approved
  state :sent
  state :read
  state :pending
  state :rejected
  state :accepted
  state :trashed

  transition from: :unsaved,  to: [:draft, :prepared, :trashed]
  transition from: :draft,    to: [:draft, :prepared, :trashed]
  transition from: :prepared, to: [:approved, :draft, :prepared, :trashed]
  transition from: :approved, to: [:sent, :prepared, :trashed]
  transition from: :sent,     to: [:read, :trashed]
  transition from: :read,     to: [:pending, :trashed]
  transition from: :pending,  to: [:rejected, :accepted, :trashed]

  after_transition(to: :approved) do |accountable, transition|
    Documents::Accounter.sign(accountable)
  end
end
