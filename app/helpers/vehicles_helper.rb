# coding: utf-8

module VehiclesHelper
  
  def vehicle_body(vehicle)
    if vehicle.vehicle_body == "passenger_car"
      "Легковой автомобиль"
    elsif vehicle.vehicle_body == "truck"
      "Грузовой автомобиль"
    elsif vehicle.vehicle_body == "special_car"
      "Спецтехника"
    else
      nil
    end
	end
	
  
end
