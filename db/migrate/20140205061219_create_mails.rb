class CreateMails < ActiveRecord::Migration
  def change
    create_table :mails do |t|
      t.integer :conversation_id

      t.timestamps
    end

    add_index :mails, :conversation_id
  end
end
