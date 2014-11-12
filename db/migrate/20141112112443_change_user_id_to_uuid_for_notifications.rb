class ChangeUserIdToUuidForNotifications < ActiveRecord::Migration
  def up
    remove_column :notifications, :user_id
    add_column :notifications, :user_id, :uuid
  end

  def down
    remove_column :notifications, :user_id
    add_column :notifications, :user_id, :integer
  end
end
