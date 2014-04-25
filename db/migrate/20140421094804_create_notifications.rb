class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :document_id, null: false
      t.integer :user_id, null: false
    end

    add_index :notifications, [:document_id, :user_id], :unique => true
  end
end
