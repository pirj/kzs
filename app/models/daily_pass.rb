class DailyPass < ActiveRecord::Base
  attr_accessible :permit_id,
                  # Посетитель
                  :last_name, :first_name, :middle_name, # Фамилия Имя Отчество
                  # Документ посетителя
                  :id_type,   # Вид документа
                  :id_series, # серия документа
                  :id_number, # номер документа

                  :object,  # Куда следует
                  :person,  # К кому
                  :issued,  # Выдан (дата выдачи)

                  # Транспортное средство (TC)
                  :has_vehicle, # Посетитель на ТС ?
                  :vehicle,     # Тип TC
                  :auto_mark,   # Марка TC
                  :auto_model,  # Модель TC
                  # Государственный регистрационный номер ТС
                  :first_letter,  # 1я буква номера
                  :sn_number,     # Цифры номера
                  :second_letter, # 2я буква номера
                  :third_letter,  # 3я буква номера
                  :lp_r,          # Номер региона

                  :date,    # ?????????
                  :guard_duty_id # какой пользователь выдал пропуск (нажал кнопку 'Выпустить')

  attr_accessor :first_letter, :second_letter, :third_letter, :sn_number

  belongs_to :permit

  before_save :create_register_sn

  # --------------------------------------------------------------------------------------------------------------------
  # Validation

  validates :permit_id, presence: true, on: :update

  validates :last_name, :first_name, :middle_name,
            #:id_type,
            :id_series, :id_number,
            :object, :person,
            presence: true

  validates :issued, presence: true # TODO date validation ! daily_pass выдается только на текущий день !

  validates :vehicle,
            :auto_mark,
            :auto_model,
            :first_letter,
            :sn_number,
            :second_letter,
            :third_letter,
            :lp_r,
            presence: { if: :has_vehicle }

  private

  def create_register_sn
    self.register_sn = self.first_letter + self.sn_number + self.second_letter + self.third_letter if has_vehicle
  end
end
