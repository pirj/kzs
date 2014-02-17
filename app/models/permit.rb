class Permit < ActiveRecord::Base
  attr_accessible :number, :purpose, :start_date, :expiration_date, :requested_duration,
                  :granted_area, :granted_object, :permit_type, :agreed, :canceled,
                  :released, :issued,
                  :permit_class, # Класс пропуска
                  :vehicle_id, :date, :vehicle_attributes,
                  :drivers, :user_attributes,
                  :way_bill, # Согласно путевого листа
                  :daily_pass_attributes, :vip_number, :user_id

  after_initialize :default_permit_class

  has_one :user
  has_one :vehicle
  has_one :daily_pass

  accepts_nested_attributes_for :vehicle
  accepts_nested_attributes_for :user
  accepts_nested_attributes_for :daily_pass

  scope :expired, lambda { where("expiration_date < ?", Date.today ) }
  scope :walkers, -> { where permit_type: 'user' }
  scope :vehicles, -> { where permit_type: 'vehicle' }
  scope :daily, -> { where permit_type: 'daily' }

  scope :for_print, lambda { where("issued = ? AND rejected = ? AND canceled = ? AND expiration_date > ?", true, false, false, Date.today) }
  scope :applications, -> { where(agreed: false) }

  attr_accessor :date, :drivers

  # TODO нужен normalize_attributes

  # TODO :agreed, :canceled, :released, :issued - нужна stat machine

  # TODO расписать назначение полей

  validates :start_date, date: { after_or_equal_to: Proc.new { Date.today } }, if: ->(f){ f.permit_type != 'daily'}
  validates :expiration_date, date: { after_or_equal_to: :start_date },        if: ->(f){ f.permit_type != 'daily'}

  #validates  :number, :purpose, :start_date, :expiration_date, :requested_duration,
  #           :granted_area, :granted_object, :permit_type, :agreed, :canceled,
  #           :released, :issued, :permit_class, :vehicle_id, :date,
  #           :drivers, :way_bill, :vip_number, :user_id,
  #           :vehicle_attributes, :user_attributes, :daily_pass_attributes,
  #           :presence => true

  TYPES = %w[user vehicle daily]
  PERMIT_CLASSES = %w[standart vip]

  protected

  def default_permit_class
    self.permit_class = PERMIT_CLASSES.first
  end
end