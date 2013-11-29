class DailyPass < ActiveRecord::Base
  attr_accessible :visitor_last_name, :permit_id, :last_name, :first_name, :middle_name,
                  :id_type, :id_sn, :vehicle, :object, :person, :issued, :date, :guard_duty
  belongs_to :permit
end
