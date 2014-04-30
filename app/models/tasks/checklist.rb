class Tasks::Checklist < ActiveRecord::Base
  attr_accessible :name, :tasks_task_id
  
  belongs_to :task
  has_many :checklist_items

  validates :name, presence: true
end
