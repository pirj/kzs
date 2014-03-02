class Task < ActiveRecord::Base
  #TODO: does deadline have to be in every model?
  attr_accessible :task_list_id, :title, :deadline, :body
  belongs_to :task_list, touch: true

  scope :completed, -> { where(completed: true) }
  scope :not_completed, -> { where(completed: false) }  
  scope :expired, lambda { where("deadline < ?", Date.today ) }

end
