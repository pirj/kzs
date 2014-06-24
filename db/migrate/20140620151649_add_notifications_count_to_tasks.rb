class AddNotificationsCountToTasks < ActiveRecord::Migration
  def change
    add_column :tasks_tasks, :notifications_count, :integer, default: 0
  end
end
