class CreateVehicleUsers < ActiveRecord::Migration
  def change
    create_table :vehicle_users do |t|
      t.integer :vehicle_id
      t.integer :user_id

      t.timestamps
    end
  end
end
