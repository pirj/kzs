class Statement < ActiveRecord::Base
  attr_accessible :title, :organization_id, :text, :file, :document_id, :user_ids
  belongs_to :document
  has_many :statement_approvers
  has_many :users, through: :statement_approvers
end