class Statement < ActiveRecord::Base
  attr_accessible :title, :organization_id, :text, :file, :document_id, :user_ids, :document_ids, :statement_approver_ids, :approver_ids
  attr_accessor :document_ids, :approver_ids
  belongs_to :document
  has_many :statement_approvers
  has_many :users, through: :statement_approvers
  
  scope :prepared, -> { where(prepared: true) }
  scope :drafts, -> { where(draft: true) }
  
  before_save :assign_approvers
  
  private
  
  def assign_approvers
    if self.approver_ids
      approver_ids = self.approver_ids.delete_if{ |x| x.empty? }
      self.user_ids = approver_ids
    end
  end
end