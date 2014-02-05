class CreateCarBrandTypes < ActiveRecord::Migration
  def change
    create_table :car_brand_types do |t|
      t.string :title

      t.timestamps
    end
  end
end
