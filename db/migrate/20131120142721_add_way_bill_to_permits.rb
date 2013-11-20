class AddWayBillToPermits < ActiveRecord::Migration
  def change
    add_column :permits, :way_bill, :boolean
  end
end
