class TaskList < ActiveRecord::Base
  attr_accessible :order_id, :tasks_attributes, :deadline
  belongs_to :order
  has_many :tasks
  accepts_nested_attributes_for :tasks, allow_destroy: true

  scope :completed, -> { where(completed: true) }

  after_commit :finalize, if: :all_tasks_complete?

  def progress
    if tasks.present?
      total = tasks.count.to_f
      completed = tasks.completed.count.to_f
      (completed / total * 100).ceil
    else
      0
    end
  end

  def all_tasks_completed?
    tasks.count == tasks.completed.count
  end

  private

  def finalize
    update_column :completed, true
  end
end
