class ReportStateMachine
  include Statesman::Machine

  state :draft, initial: true
  state :prepared
  state :signed
  state :sent
  state :accepted
  state :trashed

  transition from: :draft,      to: [:prepared, :trashed]
  transition from: :prepared,      to: [:signed, :trashed]
  transition from: :signed, to: [:sent, :trashed]
  transition from: :sent, to: [:accepted, :trashed]

end