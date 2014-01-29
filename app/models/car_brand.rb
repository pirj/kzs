class CarBrand < ActiveRecord::Base
  attr_accessible :title, :brand_type
  
  scope :passenger_cars, -> { where(brand_type: 1) }
  scope :trucks, -> { where(brand_type: 2) }
end
