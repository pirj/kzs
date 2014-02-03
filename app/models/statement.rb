class Statement < ActiveRecord::Base
  attr_accessible :title, :organization_id, :text, :file, :document_id, :user_ids, :document_ids,
                  :statement_approver_ids, :approver_ids, :approver_id, :internal_approver_id
  attr_accessor :document_ids, :approver_ids, :internal_approver_id
  belongs_to :document
  has_many :statement_approvers
  has_many :users, through: :statement_approvers
  has_one :task_list, :dependent => :destroy
  
  
  validates :document_id, :title, :text, :presence => true
  
  scope :prepared, -> { where(prepared: true) }
  scope :drafts, -> { where(draft: true) }
  scope :unopened, -> { where(opened: false) }
  scope :completed, -> { where(with_completed_task_list: true) }
  
  
  before_save :assign_approvers
  
  private
  
  def assign_approvers
    if self.approver_ids
      approver_ids = self.approver_ids.delete_if{ |x| x.empty? }
      # TODO откуда может в этом аттрибуте браться мусор в виде пустых строк и массивов?
      # если такой возможности нет, то а) compact б) user_ids === approvers_ids
      self.user_ids = approver_ids
    end
  end
end