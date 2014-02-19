class Documents::ReportStateMachine
  include Statesman::Machine
  include Documents::StateMachine

  state :unsaved, initial: true
  state :draft
  state :prepared
  state :sent
  state :read
  state :accepted
  state :rejected
  state :trashed

  transition from: :unsaved, to: [:draft, :prepared, :trashed]
  transition from: :draft,      to: [:prepared, :trashed]
  transition from: :prepared,   to: [:sent, :trashed]
  transition from: :sent,       to: [:read, :trashed]
  transition from: :read,       to: [:accepted, :rejected, :trashed]

  after_transition(to: :accepted) do |accountable, transition|
    Documents::Accounter.sign(accountable)
  end

end