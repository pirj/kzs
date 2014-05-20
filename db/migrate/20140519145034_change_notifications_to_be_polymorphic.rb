class ChangeNotificationsToBePolymorphic < ActiveRecord::Migration
  def up
    change_table :notifications do |t|
      t.rename :document_id, :notifiable_id
      t.string :notifiable_type
    end

    remove_index :notifications, [:document_id, :user_id]
    add_index :notifications, [:notifiable_id, :notifiable_type, :user_id], unique: true, name: 'notification_uniqueness'

    Notification.all.each {|n| n.notifiable_type = 'Document'}
  end

  def down
    change_table :notifications do |t|
      t.remove :notifiable_id
      t.remove :notifiable_type
      t.integer :document_id
    end  
  end
end
