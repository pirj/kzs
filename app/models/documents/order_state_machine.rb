class Documents::OrderStateMachine
  include Statesman::Machine

  state :unsaved, initial: true
  state :draft
  state :prepared
  state :approved
  state :sent
  state :accepted
  state :rejected
  state :trashed

  transition from: :unsaved,  to: [:draft, :prepared, :trashed]
  transition from: :draft,    to: [:draft, :prepared, :trashed]
  transition from: :prepared, to: [:approved, :draft, :prepared, :trashed]
  transition from: :approved, to: [:sent]
  transition from: :sent,     to: [:rejected, :accepted]

  after_transition(to: :approved) do |accountable, transition|
    Documents::Accounter.sign(accountable)
  end
end
