class AddTypeOfOwnershipToOrganization < ActiveRecord::Migration
  def change
    add_column :organizations, :type_of_ownership, :string
    remove_column :organizations, :address
    add_column :organizations, :legal_address, :string
    add_column :organizations, :actual_address, :string
  end
end
