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
  transition from: :sent,     to: [:accepted, :rejected]

  after_transition(to: :approved) do |accountable, transition|
    Documents::Accounter.sign(accountable)
  end

  # TODO: @prikha remove this guards and references from
  # /app/models/documents/report_state_machine.rb
  guard_transition(to: :accepted) do |order|
    Documents::Report.where(order_id: order.id).with_state(%w(sent accepted rejected)).exists?
  end

  guard_transition(to: :rejected) do |order|
    Documents::Report.where(order_id: order.id).with_state(%w(sent accepted rejected)).exists?
  end
end
