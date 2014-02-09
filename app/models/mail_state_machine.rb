class MailStateMachine
  include Statesman::Machine

  state :draft, initial: true
  state :signed
  state :sent
  state :read
  state :replied
  state :trashed

  transition from: :draft,      to: [:sent, :trashed]
  transition from: :signed, to: [:sent, :trashed]
  transition from: :read, to: [:replied, :trashed]

end