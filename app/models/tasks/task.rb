class Tasks::Task < ActiveRecord::Base
  # Нотификации
  include Notifiable
  default_interesants :inspector, :executor

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

  has_many :checklists, inverse_of: :task
  has_many :notifications, as: :notifiable, dependent: :destroy

  accepts_nested_attributes_for :checklists, allow_destroy: true
  #default_scope order('created_at DESC')
  scope :for_organization, ->(org) { where(organization_id: org) }
  scope :parents_only, where(parent_id: nil)
  scope :by_started_at, order('started_at ASC')

  validates :title, :executor_id, :inspector_id, :organization_id, presence: true
  validates :started_at, timeliness: {on_or_after: -> { DateTime.now }, type: :date}, on: :create, if: Proc.new {|task| task.parent.nil?}
  validates :finished_at, timeliness: {type: :date}, if: Proc.new{|task| task.parent.nil?}

  # Если есть parent_id
  validates :started_at,  timeliness: {on_or_after: ->  { parent.started_at  } }, if: Proc.new {|task| task.parent}
  validates :finished_at, timeliness: {on_or_before: -> { parent.finished_at } }, if: Proc.new {|task| task.parent}

  validate :start_must_be_before_end_time
  validate :validate_parent_start_date
  validate :validate_parent_end_date

  after_create :send_create_notifications
  after_update :send_update_notifications

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

private
  def send_create_notifications
    notify_interesants exclude: (updated_by ? User.find(updated_by) : [])

    interesants.reject{|u| u == User.find(updated_by) if updated_by}.each do |user|
      NotificationMailer.delay.task_created(user, self)
    end
  end

  def send_update_notifications
      notify_interesants exclude: (updated_by ? User.find(updated_by) : [])

      [inspector.id, executor.id, inspector_id_was, executor_id_was].compact.uniq.map {|id| User.find(id)}.reject{|u| u == User.find(updated_by) if updated_by}.each do |user|
        NotificationMailer.delay.task_changed(user, self)
      end
  end

  def start_must_be_before_end_time
      errors.add(:started_at, "не должна быть позже даты окончания задачи") unless (started_at <= finished_at) unless started_at.nil? && finished_at.nil?
  end

  def validate_parent_start_date
    errors.add(:started_at, "не должна быть раньше даты начала родительской задачи") if parent && parent.started_at && (started_at < parent.started_at) 
  end

  def validate_parent_end_date
    errors.add(:finished_at, "не должна быть позже даты окончания родительской задачи") if parent && parent.finished_at && (finished_at > parent.finished_at) 
  end

end
