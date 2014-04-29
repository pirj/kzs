class RemoveOpenNotices < ActiveRecord::Migration
  def up
    drop_table :open_notices
  end

  def down
    create_table :open_notices do |t|
      t.integer :document_id
      t.integer :user_id

      t.timestamps
    end
  end
end
