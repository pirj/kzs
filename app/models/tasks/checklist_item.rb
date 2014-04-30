class Tasks::ChecklistItem < ActiveRecord::Base
  attr_accessible :name, :description, :checklist_id, :checked
  
  belongs_to :checklist

  validates :name, :checklist_id, presence: true
end
