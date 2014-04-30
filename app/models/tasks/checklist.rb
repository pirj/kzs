class Tasks::Checklist < ActiveRecord::Base
  attr_accessible :name, :tasks_task_id
  
  belongs_to :task

  validates :name, presence: true
end
