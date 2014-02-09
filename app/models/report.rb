class Report < ActiveRecord::Base
  include Accountable

  attr_accessible :order_id
  belongs_to :order

  def state_machine
    Documents::ReportStateMachine.new(self, transition_class: DocumentTransition)
  end

  delegate :can_transition_to?, :transition_to!, :transition_to, :current_state,
           to: :state_machine


end
