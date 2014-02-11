class Documents::Mail < ActiveRecord::Base
  include Accountable
  attr_accessible :conversation_id, :conversation

  belongs_to :conversation, class_name: 'DocumentConversation', foreign_key: 'conversation_id'

  def state_machine
    Documents::MailStateMachine.new(self, transition_class: DocumentTransition)
  end

  delegate :can_transition_to?, :transition_to!, :transition_to, :current_state,
           to: :state_machine

  before_save :build_conversation

  private

  def build_conversation
    self.conversation ||= build_conversation
  end

  # TODO: add paranoia - this will handle the destruction

  # TODO: add state machine and define
  # data to be preserved about the transition
  # 1) simple scopes
  # 2) should we store most transitions timestamps?
  # 3) should we store most transitions initiators(user_id who did it)?

  # https://github.com/wvanbergen/state_machine-audit_trail can store additional data in transitions
  # difficult to scope by additional data

  # https://github.com/gocardless/statesman
  # difficult scopes

#  https://github.com/troessner/transitions
#  build in timestamps but we can also do it in callbacks

#  aasm and workflow are also an option
end
