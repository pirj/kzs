class TaskList < ActiveRecord::Base
  attr_accessible :order_id, :tasks_attributes, :deadline
  belongs_to :order
  has_many :tasks
  accepts_nested_attributes_for :tasks, allow_destroy: true
  
  scope :completed, -> { where(completed: true) }
  
  #TODO: @prikha do nothing for now
  #after_save :update_statement
  
  def progress
    if self.tasks.present?
      total = tasks.count.to_f
      completed = tasks.completed.count.to_f
      (completed/total*100).ceil
    else
      0
    end
  end
  
  def all_tasks_completed?
    self.tasks.count == self.tasks.completed.count
  end

  private

  # TODO: @prikha removed old code
  #def update_statement
  #  if self.completed && self.order
  #  end
  #end
  

    
end
