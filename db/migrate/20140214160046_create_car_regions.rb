class CreateCarRegions < ActiveRecord::Migration
  def change
    create_table :car_regions do |t|
      t.string :number
      t.string :name

      t.timestamps
    end
  end
end
