class Tasks::ChecklistItem < ActiveRecord::Base
  attr_accessible :name, :description, :checklist_id, :checked, :finished_at
  
  belongs_to :checklist

  validates :name, presence: true

  validate :finished_at_should_be_within_task_time

  after_update :send_notifications

private
  def finished_at_should_be_within_task_time
    unless finished_at.nil? || checklist.task.started_at.nil? || checklist.task.finished_at.nil?
      errors.add(:finished_at, "должна не выходить за рамки задачи") unless finished_at.between? checklist.task.started_at, checklist.task.finished_at
    end
  end

  def send_notifications
    # Если чекбокс снят/установлен - отправляем нотификации и письмо
    if changed.include? 'checked'
      checklist.task.notify_interesants exclude: User.find(checklist.updated_by)

      # Всем интересантам отправляем письма
      checklist.task.interesants
        .reject {|i| i == User.find(checklist.updated_by)}
        .each {|i| NotificationMailer.delay.task_checklist_item_changed(i, self) }
    end
  end
end
