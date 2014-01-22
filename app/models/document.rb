class Document < ActiveRecord::Base
  attr_accessible :deadline, :file, :organization_id, :recipient_id, :text,
                  :title, :user_id, :approver_id, :opened, :for_approve, 
                  :deleted, :archived, :callback, :prepared, :document_type,
                  :attachment, :executor_id, :confidential, :document_attachments_attributes,
                  :document_ids, :organization_ids, :document_attachments, 
                  :document_conversation_id, :sender_organization_id, :executor_ids, :approver_ids, 
                  :task_list_attributes, :prepared_date, :draft, :approved, :approved_date, :date, :sn, :sent, :sent_date

  attr_accessor :organization_ids, :executor_ids, :approver_ids
  
  validates :title, :organization_id, :approver_id, :executor_id, :text, :presence => true
                  
  belongs_to :project
  belongs_to :document_conversation
  has_many :statements
  has_many :document_attachments
  has_one :task_list
  has_one :task

  accepts_nested_attributes_for :document_attachments, allow_destroy: true
  accepts_nested_attributes_for :task_list, allow_destroy: true
  
  has_and_belongs_to_many :documents, class_name: "Document", uniq: true,
                          join_table: "document_relations", 
                          foreign_key: "document_id", 
                          association_foreign_key: "relational_document_id"
 
  belongs_to :parent_document, class_name: "Document"
  
  scope :draft, -> { where(draft: true) }   
  scope :not_draft, -> { where(draft: false) } 
  
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
  
  scope :with_completed_tasks, includes(:task_list).where(:task_list => {:completed => true})  
  scope :with_completed_tasks_in_statement, includes(:statements).where(:statements => {:with_completed_task_list => true})

  DOCUMENT_TYPES = ["mail", "writ"]
  
  def self.text_search(query)
    if query.present?
      search(query)
    else
      scoped
    end
  end
  
  def self.with_statements
    includes(:statements).where('documents.id in (?)',Document.writs)
  end
  
  def self.without_statements
    includes(:statements).where(:statements => {:id => nil})
  end

  def generate_png
    pdf = DocumentPdf.new(self, 'show')
    filename = "document_#{self.id}.pdf"
    pdf.render_file "tmp/#{filename}"
    pdf = Magick::ImageList.new("tmp/document_#{id}.pdf")
    thumb = pdf.scale(190, 270)
    thumb.write "app/assets/images/document_#{id}.png"
  end

end