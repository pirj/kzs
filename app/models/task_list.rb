class TaskList < ActiveRecord::Base
  attr_accessible :order_id, :tasks_attributes, :deadline
  belongs_to :order
  has_many :tasks


  accepts_nested_attributes_for :tasks, allow_destroy: true


  # TODO: move to decorator

  scope :completed, -> { where(completed: true) }

  after_commit :finalize, if: :all_tasks_completed?

  #validates :deadline, presence: true



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
    tasks.count > 0 && tasks.count == tasks.completed.count
  end

  alias_method :completed?, :completed
end
