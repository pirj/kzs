class CreateMails < ActiveRecord::Migration
  def change
    create_table :mails do |t|
      t.integer :conversation_id

      t.timestamps
    end
  end
end
