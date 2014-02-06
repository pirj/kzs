class Mail < ActiveRecord::Base
  attr_accessible :conversation_id, :document_attributes

  #TODO: uncomment for REPLY functionality
  #belongs_to :conversation, class_name: 'DocumentConversation', foreign_key: 'conversation_id'

  has_one :document, as: :accountable, class_name: 'Doc', dependent: :destroy
  accepts_nested_attributes_for :document

  def method_missing(method, *args)
    return document.send(method, *args) if document.respond_to?(method)
    super
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
