class Tasks::Task < ActiveRecord::Base

  # TODO-justvitalius: хук для того,чтобы эти таски работали только с этой таблицей, а не просто с Task
  self.table_name = 'tasks_tasks'

  attr_accessible :text,
                  :title,
                  :organization,
                  :organization_id,
                  :executors,
                  :executor_ids,
                  :inspectors,
                  :inspector_ids,
                  :started_at,
                  :finished_at,
                  :checklists_attributes,
                  :parent_id,
                  :parent

  has_many :subtasks, class_name: "Task", foreign_key: :parent_id
  belongs_to :parent, class_name: "Task"



  has_and_belongs_to_many :executors, class_name: 'User', join_table: "tasks_tasks_executors"
  has_and_belongs_to_many :inspectors, class_name: 'User', join_table: "tasks_tasks_inspectors"
  belongs_to :organization

  has_many :checklists
  has_many :notifications, as: :notifiable, dependent: :destroy

  accepts_nested_attributes_for :checklists, allow_destroy: true
  default_scope order('created_at DESC')
  scope :for_organization, ->(org) { where(organization_id: org) }

  validates :title, :text, :executor_ids, :inspector_ids, :organization_id, :presence => true

  scope :overdue, -> { where('finished_at <= ?', Time.now )}

  include Workflow

  workflow_column :state

  workflow do
    state :formulated do
      event :cancel, transitions_to: :cancelled
      event :start, transitions_to: :activated
    end

    state :activated do
      event :cancel, transitions_to: :cancelled
      event :finish, transitions_to: :executed
      event :pause, transitions_to: :paused
    end

    state :paused do
      event :resume, transitions_to: :activated
    end

    state :executed do
      event :reformulate, transitions_to: :formulated
    end

    state :cancelled
  end


end
