class AddHasVehicleToDailyPasses < ActiveRecord::Migration
  def change
    add_column :daily_passes, :has_vehicle, :boolean, default: false
  end
end
