class CreateVehicles < ActiveRecord::Migration
  def change
    create_table :vehicles do |t|
      t.string :brand
      t.string :model
      t.string :vehicle_body
      t.string :register_document
      t.string :register_sn

      t.timestamps
    end
  end
end
