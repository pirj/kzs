class Order < ActiveRecord::Base
  attr_accessible :deadline, :document_attributes

  #TODO: uncomment for REPLY functionality
  #belongs_to :conversation, class_name: 'DocumentConversation', foreign_key: 'conversation_id'

  has_one :document, as: :accountable, class_name: 'Doc', dependent: :destroy
  accepts_nested_attributes_for :document

  def state_machine
    OrderStateMachine.new(self, transition_class: DocumentTransition)
  end

  delegate :can_transition_to?, :transition_to!, :transition_to, :current_state,
           to: :state_machine

  def method_missing(method, *args)
    return document.send(method, *args) if document.respond_to?(method)
    super
  end


end
