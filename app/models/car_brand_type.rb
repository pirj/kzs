class CarBrandType < ActiveRecord::Base
  attr_accessible :title
  has_many :car_brands
end
