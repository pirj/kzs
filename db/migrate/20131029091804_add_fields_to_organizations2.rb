class AddFieldsToOrganizations2 < ActiveRecord::Migration
  def change
    add_column :organizations, :inn, :integer, precision: 10, scale: 0
    add_column :organizations, :short_title, :string
    add_column :organizations, :admin_id, :integer
  end
end
