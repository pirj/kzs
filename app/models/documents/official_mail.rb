class Documents::OfficialMail < ActiveRecord::Base
  include Accountable
  attr_accessible :conversation_id, :conversation

  belongs_to :conversation, class_name: 'DocumentConversation', foreign_key: 'conversation_id', autosave: true

  def state_machine
    OfficialMailStateMachine.new(self, transition_class: DocumentTransition)
  end

  delegate :can_transition_to?, :transition_to!, :transition_to, :current_state,
           to: :state_machine

  private
  # TODO: add paranoia - this will handle the destruction


end
