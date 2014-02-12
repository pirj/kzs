class Task < ActiveRecord::Base
  #TODO: does deadline have to be in every model?
  attr_accessible :task_list_id, :task, :deadline

  belongs_to :task_list
  belongs_to :document #TODO delete if not needed


  scope :completed, -> { where(completed: true) }  
  scope :not_completed, -> { where(completed: false) }  
  scope :expired, lambda { where("deadline < ?", Date.today ) }

end
