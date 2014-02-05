class Mail < ActiveRecord::Base
  attr_accessible :conversation_id

  belongs_to :conversation, class_name: 'DocumentConversation', foreign_key: 'conversation_id'
  has_one :document

end
