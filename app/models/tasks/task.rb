class Tasks::Task < ActiveRecord::Base
  attr_accessible :text,
                  :title,
                  :organization,
                  :organization_id,
                  :executor,
                  :executor_id,
                  :inspector,
                  :inspector_id,
                  :started_at,
                  :finished_at,
                  :checklists_attributes,
                  :parent_id,
                  :parent

  has_many :subtasks, class_name: 'Task', foreign_key: :parent_id
  belongs_to :parent, class_name: 'Task'

  belongs_to :executor, class_name: 'User'
  belongs_to :inspector, class_name: 'User'
  belongs_to :organization

  has_many :checklists
  has_many :notifications, as: :notifiable, dependent: :destroy

  accepts_nested_attributes_for :checklists, allow_destroy: true
  default_scope order('created_at DESC')
  scope :for_organization, ->(org) { where(organization_id: org) }
  scope :parents_only, where(parent_id: nil)

  validates :title, :text, :executor_id, :inspector_id, :organization_id, :presence => true


  validates :started_at, timeliness: {
      on_or_after: -> { DateTime.now },
      type: :date
  }

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
