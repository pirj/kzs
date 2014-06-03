class Tasks::ChecklistItem < ActiveRecord::Base
  attr_accessible :name, :description, :checklist_id, :checked, :finished_at
  
  belongs_to :checklist

  validates :name, presence: true

  validate :finished_at_should_be_within_task_time

private
  def finished_at_should_be_within_task_time
    unless finished_at.nil? || checklist.task.started_at.nil? || checklist.task.finished_at.nil?
      errors.add(:finished_at, "должна не выходить за рамки задачи") unless finished_at.between? checklist.task.started_at, checklist.task.finished_at
    end
  end
end
