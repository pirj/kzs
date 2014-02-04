class AddOrganizationIdToLicenses < ActiveRecord::Migration
  def change
    add_column :licenses, :organization_id, :integer
  end
end
