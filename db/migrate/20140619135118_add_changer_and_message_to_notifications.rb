class AddChangerAndMessageToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :changer_id, :integer
    add_column :notifications, :message, :string
  end
end
