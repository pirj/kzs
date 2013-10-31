# coding: utf-8

class Vehicle < ActiveRecord::Base
  attr_accessible :brand, :model, :register_document, :vehicle_body, :register_sn, :permit_id
  belongs_to :permit
  
  WORK_STATUSES = %w[passenger_car truck special_car]
  
  LETTERS = %w[A B E K M H O P C T Y X]
  
  def vehicle_title
    "#{register_sn} #{brand} #{model}"
  end
end
