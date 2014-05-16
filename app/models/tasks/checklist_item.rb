class Tasks::ChecklistItem < ActiveRecord::Base
  attr_accessible :name, :description, :checklist_id, :checked, :finished_at
  
  belongs_to :checklist

  validates :name, presence: true

  #def finished_at
  #  (self.checklist.task.started_at + rand(3).days).strftime("%d-%m-%Y")
  #end
end
