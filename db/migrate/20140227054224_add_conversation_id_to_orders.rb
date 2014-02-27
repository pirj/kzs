class AddConversationIdToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :conversation_id, :integer
    add_index :orders, :conversation_id
  end
end
