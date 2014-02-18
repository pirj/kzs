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
                  :has_russian_register_sn, # регистрационный номер РФ ?
                  :register_sn,   # полный номер
                  :first_letter,  # 1я буква номера
                  :sn_number,     # Цифры номера
                  :second_letter, # 2я буква номера
                  :third_letter,  # 3я буква номера
                  :lp_r,          # Номер региона

                  :date,    # ?????????
                  :guard_duty_id # какой пользователь выдал пропуск (нажал кнопку 'Выпустить')

  attr_writer :first_letter, :second_letter, :third_letter, :sn_number

  belongs_to :permit

  after_initialize :set_default_issued
  before_save :create_register_sn

  # --------------------------------------------------------------------------------------------------------------------
  # Validation

  validates :permit_id, presence: true, on: :update

  validates :last_name, :first_name, :middle_name,
            :id_type,
            :id_series, :id_number,
            :object, :person,
            presence: true

  validates :issued, date: { after_or_equal_to: Proc.new { Date.today },
                             before_or_equal_to: Proc.new { Date.today }, message: :must_be_current_date }

  validates :vehicle,
            :auto_mark,
            :auto_model,
            presence: { if: :has_vehicle }

  validates :register_sn, presence:  { if: ->{ has_vehicle && !has_russian_register_sn } }

  validates :first_letter,
            :sn_number,
            :second_letter,
            :third_letter,
            :lp_r,
            presence: { if: ->{ has_vehicle && has_russian_register_sn } }

  def first_letter
    @first_letter || self.has_vehicle && self.has_russian_register_sn && self.register_sn && self.register_sn[0] || nil
  end

  def second_letter
    @second_letter || self.has_vehicle && self.has_russian_register_sn && self.register_sn && self.register_sn[-2] || nil
  end

  def third_letter
    @third_letter || self.has_vehicle && self.has_russian_register_sn && self.register_sn && self.register_sn[-1] || nil
  end

  def sn_number
    @sn_number || self.has_vehicle && self.has_russian_register_sn && self.register_sn && self.register_sn[1..-3] || nil
  end

  private

  def create_register_sn
    self.register_sn = self.first_letter + self.sn_number + self.second_letter + self.third_letter if has_vehicle && has_russian_register_sn
  end

  protected

  def set_default_issued
    self.issued = Date.today if self.new_record? && self.issued.nil?
  end
end
