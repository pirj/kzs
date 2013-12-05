class TaskList < ActiveRecord::Base
  attr_accessible :statement_id, :tasks_attributes
  belongs_to :statement
  belongs_to :document
  has_many :tasks
  accepts_nested_attributes_for :tasks, allow_destroy: true
  
  def progress
    
    
    self.tasks.count
    
  end
  
end
