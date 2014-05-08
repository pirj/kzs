class Tasks::Task < ActiveRecord::Base
  attr_accessible :text, :title,
                  :organization, :organization_id,
                  :executors, :executor_ids,
                  :approvers, :approver_ids,
                  :started_at, :finished_at, :checklists_attributes
  
  has_and_belongs_to_many :executors, class_name: 'User', join_table: "tasks_tasks_executors"
  has_and_belongs_to_many :approvers, class_name: 'User', join_table: "tasks_tasks_approvers"
  belongs_to :organization

  has_many :checklists
  accepts_nested_attributes_for :checklists, allow_destroy: true
  default_scope order('created_at DESC')
  scope :for_organization, ->(org) { where(organization_id: org) }

  validates :title, :text, :executor_ids, :approver_ids, :organization_id, :presence => true

  include Workflow

  workflow_column :state

  workflow do
    state :formulated do
      event :cancel, transitions_to: :cancelled
      event :start, transitions_to: :active
    end

    state :active do
      event :cancel, transitions_to: :cancelled
      event :finish, transitions_to: :executed
      event :pause, transitions_to: :paused
    end

    state :paused do
      event :resume, transitions_to: :active
    end

    state :executed do
      event :reformulate, transitions_to: :formulated
    end

    state :cancelled
  end
end
