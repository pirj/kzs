class AddFieldsToPermits < ActiveRecord::Migration
  def change
    add_column :permits, :vehicle_id, :integer
    add_column :permits, :permit_class, :string 
  end
end