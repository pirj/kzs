class Tasks::Task < ActiveRecord::Base
  attr_accessible :text, :title, :text, :started_at, :finished_at
  
  has_and_belongs_to_many :executors, class_name: 'User', join_table: "tasks_tasks_executors"
  has_and_belongs_to_many :approvers, class_name: 'User', join_table: "tasks_tasks_approvers"
end
