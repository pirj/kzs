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
  transition from: :approved, to: [:sent, :prepared, :trashed]#какая то чушь получается - если подпись снята, то документ снова "подготовлен"
  transition from: :sent, to: [:read, :trashed]
  transition from: :read, to: [:trashed]

end