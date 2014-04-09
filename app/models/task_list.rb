class TaskList < ActiveRecord::Base
  attr_accessible :order_id, :tasks_attributes, :deadline
  belongs_to :order
  has_many :tasks

  accepts_nested_attributes_for :tasks, allow_destroy: true

  #validates :tasks, length: {minimum: 1}

  def progress
    if tasks.present?
      total = tasks.count.to_f
      completed = tasks.completed.count.to_f
      (completed / total * 100).ceil
    else
      0
    end
  end

  def completed
    tasks.count > 0 && tasks.map(&:completed).all?
  end

  alias_method :completed?, :completed
end
