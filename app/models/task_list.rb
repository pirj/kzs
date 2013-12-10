class TaskList < ActiveRecord::Base
  attr_accessible :statement_id, :tasks_attributes
  belongs_to :statement
  belongs_to :document
  has_many :tasks
  accepts_nested_attributes_for :tasks, allow_destroy: true
  
  scope :completed, -> { where(completed: true) }   
  
  def progress
    total = 100 / self.tasks.count
    progress = total * self.tasks.completed.count
    progress
  end
  
  def with_completed_tasks
    if self.tasks.count == self.tasks.completed.count
      true
    else
      false
    end
  end
    

  
end
