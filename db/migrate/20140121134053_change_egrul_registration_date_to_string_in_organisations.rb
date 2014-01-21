class ChangeEgrulRegistrationDateToStringInOrganisations < ActiveRecord::Migration
  def up
    change_column :organizations, :egrul_registration_date, :date
  end

  def down
    change_column :organizations, :egrul_registration_date, :string
  end
end
