class RemoveNotificationsCountFromTasksTasks < ActiveRecord::Migration
  def up
    remove_column :tasks_tasks, :notifications_count
  end

  def down
    add_column :tasks_tasks, :notifications_count, :integer, default: 0
  end
end
