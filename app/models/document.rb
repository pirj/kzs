class Document < ActiveRecord::Base
  attr_accessible :deadline, # распоряжение срок исполнения
                  :file, #убираем
                  :text,
                  :title,
                  :sn, #уникальный серийный номер - можно его опустить
                  :opened,
                  :for_approve,
                  :confidential,#только для гендиректора
                  :organization_id,
                  :recipient_id,
                  :user_id, #тот который правил последним
                  :approver_id,
                  :executor_id,
                  :sender_organization_id,
                  :document_conversation_id,
                  :deleted,
                  :archived,
                  :callback,
                  :prepared,
                  :draft,
                  :approved,
                  :document_type,
                  :task_list_attributes, #рапоряжение
                  :document_ids,
                  :organization_ids,
                  :executor_ids,# исполнитель
                  :approver_ids,# контрольное лицо - уполномоченное лицо
                  :document_attachments,
                  :attachment,
                  :document_attachments_attributes,
                  :prepared_date,
                  :approved_date,
                  :date,
                  :sent,
                  :sent_date

  attr_accessor :organization_ids, :executor_ids, :approver_ids

  after_save :create_png
  

  belongs_to :project
  belongs_to :document_conversation
  belongs_to :parent_document, class_name: "Document"
  belongs_to :sender, foreign_key: :sender_organization_id, class_name: 'Organization'
  belongs_to :recipient, foreign_key: :recipient_id, class_name: 'Organization'
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



  validates :title, :organization_id, :approver_id, :executor_id, :text, :presence => true


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

  def create_png
    pdf = DocumentPdf.new(self, 'show')
    pdf.render_file "tmp/document_#{self.id}.pdf"
    pdf = Magick::Image.read("tmp/document_#{self.id}.pdf").first
    thumb = pdf.scale(400, 520)
    thumb.write "app/assets/images/document_#{self.id}.png"
  end

end