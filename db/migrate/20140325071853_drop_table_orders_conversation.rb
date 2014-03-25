class DropTableOrdersConversation < ActiveRecord::Migration
  def up
    drop_table :orders_conversations
  end

  def down
    create_table :orders_conversations do |t|

      t.timestamps
    end
  end
end
