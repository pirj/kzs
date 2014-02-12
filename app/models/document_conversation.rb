class DocumentConversation < ActiveRecord::Base
  has_many :official_mails, class_name: 'Documents::OfficialMail', foreign_key: :conversation_id

end
