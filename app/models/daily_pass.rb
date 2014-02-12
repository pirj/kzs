class DailyPass < ActiveRecord::Base
  attr_accessible :visitor_last_name,
                  :permit_id,
                  :last_name, :first_name, :middle_name,
                  :id_type, :vehicle, :object, :person, :issued, :date, :guard_duty,
                  :lp_r, :register_sn, :auto_mark, :auto_model,
                  :first_letter, :second_letter, :third_letter, :sn_number, :id_series, :id_number,
                  :has_vehicle

  attr_accessor :first_letter, :second_letter, :third_letter, :sn_number

  belongs_to :permit

  before_save :create_register_sn

  private

  def create_register_sn
    self.register_sn = self.first_letter + self.sn_number + self.second_letter + self.third_letter
  end
end
