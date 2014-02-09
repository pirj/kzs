class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.datetime :deadline

      t.timestamps
    end
  end
end
