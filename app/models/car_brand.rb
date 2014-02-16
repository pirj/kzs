class CarBrand < ActiveRecord::Base
  attr_accessible :title, :car_brand_type_id
  attr_accessor :types
  belongs_to :car_brand_type
  
  scope :passenger_cars, -> { where(car_brand_type_id: 1) }
  scope :trucks, -> { where(car_brand_type_id: 2) }
  scope :special_cars, -> { where(car_brand_type_id: 3) }
  scope :bus, -> { where(car_brand_type_id: 4) }

  def types
    %w[passenger_car truck special_car bus]
  end
end
