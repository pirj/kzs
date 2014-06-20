class AddNotificationsCountToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :notifications_count, :integer, default: 0
  end
end
