class AddTypeToCarBrand < ActiveRecord::Migration
  def change
    add_column :car_brands, :brand_type, :integer
  end
end
