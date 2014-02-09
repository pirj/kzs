class Report < ActiveRecord::Base
  attr_accessible :order_id, :document_attributes

  has_one :document, as: :accountable, class_name: 'Doc', dependent: :destroy
  accepts_nested_attributes_for :document

  def state_machine
    ReportStateMachine.new(self, transition_class: DocumentTransition)
  end

  delegate :can_transition_to?, :transition_to!, :transition_to, :current_state,
           to: :state_machine

  def method_missing(method, *args)
    return document.send(method, *args) if document.respond_to?(method)
    super
  end


end
