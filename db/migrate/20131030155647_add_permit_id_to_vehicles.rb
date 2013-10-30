class AddPermitIdToVehicles < ActiveRecord::Migration
  def change
    add_column :vehicles, :permit_id, :integer
  end
end
