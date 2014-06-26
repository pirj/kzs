class RemoveNotificationsCountFromDocuments < ActiveRecord::Migration
  def up
    remove_column :documents, :notifications_count
  end

  def down
    add_column :documents, :notifications_count, :integer, default: 0
  end
end
