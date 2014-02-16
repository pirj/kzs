# coding: utf-8

class Vehicle < ActiveRecord::Base
  attr_accessible :permit_id,
                  # Транспортное средство (TC)
                  :vehicle_body, # Тип ТС
                  :brand,        # Марка TC
                  :model,        # Модель TC
                  :register_document, # Номер свидетельства регистрации
                  # Государственный регистрационный номер ТС
                  :has_russian_register_sn, # регистрационный номер РФ ?
                  :register_sn,   # полный номер
                  :first_letter,  # 1я буква номера
                  :sn_number,     # Цифры номера
                  :second_letter, # 2я буква номера
                  :third_letter,  # 3я буква номера
                  :sn_region,     # Номер региона
                  #
                  :user_ids # ids водителей (пункт 2. Водители)

  validates :permit_id, presence: true, on: :update


  validates :vehicle_body,
            :brand,
            :model,
            :register_document,
            presence: true

  validates :register_sn, presence: { unless: :has_russian_register_sn }

  validates :first_letter,
            :sn_number,
            :second_letter,
            :third_letter,
            :sn_region,
            presence: { if: :has_russian_register_sn }

  # TODO как валидировать это поле при создании новой записи ?
  #validates  :user_ids,
  #            presence: { if: ->(f){ f.permit.permit_type == 'vehicle' && f.permit.way_bill } }

  attr_accessor :first_letter, :second_letter, :third_letter, :sn_number

  belongs_to :permit

  has_many :vehicle_users
  has_many :users, :through => :vehicle_users

  before_save :create_register_sn

  LETTERS = %w[A B E K M H O P C T Y X]
  VEHICLE_BODY = %w[passenger_car truck special_car bus]

  def vehicle_title
    "#{register_sn}#{sn_region} #{brand} #{model}"
  end

  private

  def create_register_sn
    self.register_sn = self.first_letter + self.sn_number + self.second_letter + self.third_letter if has_russian_register_sn
  end
end
