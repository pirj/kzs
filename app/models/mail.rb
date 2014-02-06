class Mail < ActiveRecord::Base
  attr_accessible :conversation_id, :document_attributes


  belongs_to :conversation, class_name: 'DocumentConversation', foreign_key: 'conversation_id'
  has_one :document, as: :accountable, class_name: 'Doc', dependent: :delete
  accepts_nested_attributes_for :document

  def method_missing(method, *args)
    return document.send(method, *args) if document.respond_to?(method)
    super
  end



end
