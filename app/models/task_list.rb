class TaskList < ActiveRecord::Base
  attr_accessible :statement_id, :tasks_attributes
  belongs_to :statement
  belongs_to :document
  has_many :tasks
  accepts_nested_attributes_for :tasks, allow_destroy: true
  
  scope :completed, -> { where(completed: true) }   
  
  after_save :update_statement
  
  def progress
    if self.tasks.present?
      total = 100 / self.tasks.count
      total * self.tasks.completed.count
    end
  end
  
  def with_completed_tasks
    if self.tasks.count == self.tasks.completed.count
      true
    else
      false
    end
  end
  
  def update_statement
    if self.completed
      if self.statement
        statement = self.statement
        statement.with_completed_task_list = true
        statement.save!
      end
    end
  end
    
end
