class Report < ActiveRecord::Base
  include Accountable

  attr_accessible :order_id, :order

  belongs_to :order

  validates_presence_of :order_id

  def state_machine
    Documents::ReportStateMachine.new(self, transition_class: DocumentTransition)
  end

  delegate :can_transition_to?, :transition_to!, :transition_to, :current_state,
           to: :state_machine


end
