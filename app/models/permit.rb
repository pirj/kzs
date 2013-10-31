class Permit < ActiveRecord::Base
  attr_accessible :number, :user_id, :purpose, :start_date, :expiration_date, :requested_duration,
                  :granted_area, :granted_object, :permit_type, :agreed, :canceled, 
                  :released, :issued, :permit_class, :vehicle_id, :date, :vehicle_attributes, :drivers
  

  
  belongs_to :user
  has_one :vehicle, :dependent => :destroy
  accepts_nested_attributes_for :vehicle
  
  attr_accessor :date, :drivers

  validates :permit_type, :permit_class, :start_date, :expiration_date, :presence => true  
  
  TYPES = %w[user vehicle]
  PERMIT_CLASSES = %w[standart vip]
end