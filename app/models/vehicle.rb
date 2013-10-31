# coding: utf-8

class Vehicle < ActiveRecord::Base
  attr_accessible :brand, :model, :register_document, :vehicle_body, :register_sn, :permit_id, :first_letter, :second_letter, :third_letter, :sn_number, :sn_region, :user_ids
  attr_accessor :first_letter, :second_letter, :third_letter, :sn_number
  belongs_to :permit
  
  has_many :vehicle_users
  has_many :users, :through => :vehicle_users
  
  before_save :create_register_sn
  
  WORK_STATUSES = %w[passenger_car truck special_car]
  
  LETTERS = %w[A B E K M H O P C T Y X]
  
  def vehicle_title
    "#{register_sn}#{sn_region} #{brand} #{model}"
  end
  
  private
  
  def create_register_sn
    self.register_sn = self.first_letter + self.sn_number + self.second_letter + self.third_letter 
  end
  
end
