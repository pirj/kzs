class TaskList < ActiveRecord::Base
  attr_accessible :statement_id, :tasks_attributes
  belongs_to :statement
  has_many :tasks
  accepts_nested_attributes_for :tasks, allow_destroy: true
end