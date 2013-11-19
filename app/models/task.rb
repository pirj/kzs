class Task < ActiveRecord::Base
  attr_accessible :task_list_id, :task
  belongs_to :task_list
end
