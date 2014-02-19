class Documents::OfficialMailStateMachine
  include Statesman::Machine
  include Documents::StateMachine

  state :draft, initial: true
  state :prepared
  state :approved
  state :sent
  state :read
  state :trashed

  transition from: :draft, to: [:prepared, :trashed]
  transition from: :prepared, to: [:approved, :trashed]
  transition from: :approved, to: [:sent, :trashed]
  transition from: :sent, to: [:read, :trashed]
  transition from: :read, to: [:trashed]

  after_transition(to: :approved) do |accountable, transition|
    Documents::Accounter.approve(accountable)
  end

end