class AddFieldsToOrganizations3 < ActiveRecord::Migration
  def change
    add_column :organizations, :date_of_registration, :datetime
    add_column :organizations, :tax_authority_that_registered, :string
    add_attachment :organizations, :certificate_of_tax_registration
    add_column :organizations, :creation_resolution_date, :datetime
    add_attachment :organizations, :creation_resolution
    add_attachment :organizations, :articles_of_organization
    add_column :organizations, :accountant_id, :integer
    add_column :organizations, :kpp, :string
    add_column :organizations, :ogrn, :string
    add_column :organizations, :bik, :string
    add_column :organizations, :egrul_registration_date, :string
    add_attachment :organizations, :egrul_excerpt
  end
end
