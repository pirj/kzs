class Tasks::Task < ActiveRecord::Base
  attr_accessible :text, :title, :text,
                  :executors, :executor_ids,
                  :approvers, :approver_ids,
                  :started_at, :finished_at
  
  has_and_belongs_to_many :executors, class_name: 'User', join_table: "tasks_tasks_executors"
  has_and_belongs_to_many :approvers, class_name: 'User', join_table: "tasks_tasks_approvers"

  default_scope order('created_at DESC')
  scope :for_org, ->(org) { where(organization_id: org) }

  validates :title, :text, :executor_ids, :approver_ids, :presence => true
end
