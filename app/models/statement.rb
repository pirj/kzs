class Statement < ActiveRecord::Base
  attr_accessible :title, :organization_id, :text, :file, :document_id, :user_ids, :document_ids, :statement_approver_ids, :approver_ids, :approver_id, :internal_approver_id
  attr_accessor :document_ids, :approver_ids, :internal_approver_id
  belongs_to :document
  has_many :statement_approvers
  has_many :users, through: :statement_approvers
  has_one :task_list, :dependent => :destroy
  
  
  validates :document_id, :title, :text, :presence => true
  
  scope :prepared, -> { where(prepared: true) }
  scope :drafts, -> { where(draft: true) }
  scope :unopened, -> { where(opened: false) }
  
  before_save :assign_approvers
  
  private
  
  def assign_approvers
    if self.approver_ids
      approver_ids = self.approver_ids.delete_if{ |x| x.empty? }
      self.user_ids = approver_ids
    end
  end
end