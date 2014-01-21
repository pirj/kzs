class ChangeEgrulRegistrationDateToStringInOrganisations < ActiveRecord::Migration
  def up
    remove_column :organizations, :egrul_registration_date
    add_column :organizations, :egrul_registration_date, :date
  end

  def down
    remove_column :organizations, :egrul_registration_date
    add_column :organizations, :egrul_registration_date, :string
  end
end
