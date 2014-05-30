class Tasks::Checklist < ActiveRecord::Base
  attr_accessible :name, :task_id, :checklist_items_attributes
  
  belongs_to :task
  has_many :checklist_items, inverse_of: :checklist

  accepts_nested_attributes_for :checklist_items, allow_destroy: true

  validates :name, presence: true

  after_update :send_notifications

private

  def send_notifications
    task.notify_interesants exclude: User.find(updated_by)
  end

end
