class Permit < ActiveRecord::Base
  attr_accessible :number, :user_id, :purpose, :start_date, :expiration_date, :requested_duration,
                  :granted_area, :granted_object, :permit_type, :agreed, :canceled, 
                  :released, :issued, :permit_class, :vehicle_id, :date, :vehicle_attributes, :drivers
  

  
  belongs_to :user
  has_one :vehicle
  accepts_nested_attributes_for :vehicle
  
  scope :expired, lambda { where("expiration_date < ?", Date.today ) }
  scope :applications, -> { where(agreed: false) }
  
  attr_accessor :date, :drivers

  validates :permit_type, :permit_class, :start_date, :expiration_date, :presence => true  
  
  TYPES = %w[user vehicle]
  PERMIT_CLASSES = %w[standart vip]
  
  def temporary
    if self.start_date == self.expiration_date
      true
    else
      false
    end
  end
  
end