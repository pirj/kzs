class AddRegionToVehicles < ActiveRecord::Migration
  def change
    add_column :vehicles, :sn_region, :integer, precision: 3, scale: 0
  end
end
