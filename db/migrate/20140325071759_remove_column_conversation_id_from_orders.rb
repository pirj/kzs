class RemoveColumnConversationIdFromOrders < ActiveRecord::Migration
  def up
    remove_column :orders, :conversation_id
  end

  def down
    add_column :orders, :conversation_id, :string
  end
end
