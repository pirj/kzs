class Vehicle < ActiveRecord::Base
  attr_accessible :brand, :model, :register_document, :vehicle_body, :register_sn
  
  WORK_STATUSES = %w[passenger_car truck special_car]
end
