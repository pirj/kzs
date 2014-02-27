class CreateOrdersConversations < ActiveRecord::Migration
  def change
    create_table :orders_conversations do |t|

      t.timestamps
    end
  end
end
