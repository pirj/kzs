class ChangeCarBrandType < ActiveRecord::Migration
  def up
    rename_column :car_brands, :brand_type, :car_brand_type_id
  end

  def down
  end
end
