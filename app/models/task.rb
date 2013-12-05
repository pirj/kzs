class Task < ActiveRecord::Base
  attr_accessible :task_list_id, :task, :deadline
  belongs_to :task_list
  scope :completed, -> { where(completed: true) }  
end
