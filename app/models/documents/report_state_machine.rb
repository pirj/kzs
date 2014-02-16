class Documents::ReportStateMachine
  include Statesman::Machine
  include Documents::StateMachine

  state :draft, initial: true
  state :prepared
  state :sent
  state :read
  state :accepted
  state :rejected
  state :trashed

  transition from: :draft,      to: [:prepared, :trashed]
  transition from: :prepared,   to: [:sent, :trashed]
  transition from: :sent,       to: [:read, :trashed]
  transition from: :read,       to: [:accepted, :rejected, :trashed]


end