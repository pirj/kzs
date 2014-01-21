class ChangeEgrulRegistrationDateToStringInOrganisations < ActiveRecord::Migration
  def up
    change_column :organisations, :egrul_registration_date, :date
  end

  def down
    change_column :organisations, :egrul_registration_date, :string
  end
end
