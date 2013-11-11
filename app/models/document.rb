class Document < ActiveRecord::Base
  attr_accessible :deadline, :file, :organization_id, :recipient_id, :text,
                  :title, :user_id, :approver_id, :opened, :for_approve, 
                  :deleted, :archived, :callback, :prepared, :document_type,
                  :attachment, :executor_id, :confidential, :document_attachments_attributes,
                  :document_ids, :organization_ids, :document_attachments, 
                  :document_conversation_id, :sender_organization_id, :executor_ids, :approver_ids
                  
  attr_accessor :organization_ids, :executor_ids, :approver_ids
                  
  belongs_to :project
  belongs_to :document_conversation
  has_many :statements
  has_many :document_attachments
  accepts_nested_attributes_for :document_attachments, allow_destroy: true
  
  has_and_belongs_to_many :documents, class_name: "Document", uniq: true,
                          join_table: "document_relations", 
                          foreign_key: "document_id", 
                          association_foreign_key: "relational_document_id"
 
  belongs_to :parent_document, class_name: "Document"
  
  scope :draft, -> { where(draft: true) }   
  scope :prepared, -> { where(prepared: true) }    
  scope :approved, -> { where(approved: true) }
  scope :not_approved, -> { where(approved: false) }
  scope :sent, -> { where(sent: true) }
  scope :not_sent, -> { where(sent: false) }
  scope :unopened, -> { where(opened: false) }
  
  scope :deleted, -> { where(deleted: true) }
  scope :not_deleted, -> { where(deleted: false) }
  
  scope :archived, -> { where(archived: true) }
  scope :not_archived, -> { where(archived: false) }
  
  scope :callback, -> { where(callback: true) }
  
  scope :mails, -> { where(document_type: 'mail') }
  scope :writs, -> { where(document_type: 'writ') }
  
  scope :confidential, -> { where(confidential: true) }
  scope :not_confidential, -> { where(confidential: false) }
  
  protect do |user|                         # `user` is a context of security

    if user.id == 47
      scope { all }                         # Admins can retrieve anything

      cannot :edit                            # ... and view anything
    else
      cannot :edit
    end
  end
  
  DOCUMENT_TYPES = ["mail", "writ"]
  
  def self.text_search(query)
    if query.present?
      search(query)
    else
      scoped
    end
  end
  

end