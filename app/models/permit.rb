class Permit < ActiveRecord::Base
  attr_accessible :number, :user_id, :purpose, :start_date, :expiration_date, :requested_duration,
                  :granted_area, :granted_object, :permit_type, :agreed, :canceled, :released, :issued
  belongs_to :user

  validates :number, :permit_type, :permit_class, :start_date, :expiration_date, :presence => true  
  
  TYPES = %w[user vehicle]
  PERMIT_CLASSES = %w[standart vip]
end