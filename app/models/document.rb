class Document < ActiveRecord::Base
  attr_accessible :deadline, :file, :organization_id, :recipient_id, :text,
                  :title, :user_id, :approver_id, :opened, :for_approve, 
                  :deleted, :archived, :callback, :prepared, :document_type,
                  :attachment, :executor_id, :confidential, :document_attachments_attributes
                  
  belongs_to :project
  has_many :statements
  has_many :document_attachments
  accepts_nested_attributes_for :document_attachments, allow_destroy: true
  
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
  
  DOCUMENT_TYPES = ["mail", "writ"]
  

end