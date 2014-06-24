class AddStartedAtForOrders < ActiveRecord::Migration
  def change
  	add_column :orders, :started_at, :datetime 
  end
end
