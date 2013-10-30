class Vehicle < ActiveRecord::Base
  attr_accessible :brand, :model, :register_document, :vehicle_body, :register_sn, :permit_id
  belongs_to :permit
  
  WORK_STATUSES = %w[passenger_car truck special_car]
  
  def vehicle_title
    "#{register_sn} #{brand} #{model}"
  end
end
