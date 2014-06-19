class RemoveUniquenessFromNotifications < ActiveRecord::Migration
  def up
    remove_index :notifications, name: 'notification_uniqueness'
  end

  def down
    add_index :notifications, [:notifiable_id, :notifiable_type, :user_id], unique: true, name: 'notification_uniqueness'
  end
end
