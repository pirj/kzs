class Permit < ActiveRecord::Base
  attr_accessible :number, :purpose, :start_date, :expiration_date, :requested_duration,
                  :granted_area, :granted_object, :permit_type, :agreed, :canceled, 
                  :released, :issued, :permit_class, :vehicle_id, :date, :vehicle_attributes, 
                  :drivers, :user_attributes, :way_bill
  

  
  has_one :user
  has_one :vehicle
  accepts_nested_attributes_for :vehicle
  accepts_nested_attributes_for :user
  
  scope :expired, lambda { where("expiration_date < ?", Date.today ) }
  scope :walkers, -> { where permit_type: 'user' }
  scope :vehicles, -> { where permit_type: 'vehicle' }
  scope :temporary, -> { where permit_type: 'temporary' }
  
  scope :for_print, lambda { where("issued = ? AND rejected = ? AND canceled = ? AND expiration_date > ?", true, false, false, Date.today) }
  scope :applications, -> { where(agreed: false) }
  
  attr_accessor :date, :drivers
  
  default_scope order('created_at DESC')

  # validates :permit_type, :permit_class, :start_date, :expiration_date, :presence => true  
  
  TYPES = %w[user vehicle temporary]
  PERMIT_CLASSES = %w[standart vip]
  
  def temporary
    if self.start_date == self.expiration_date
      true
    else
      false
    end
  end

  
end