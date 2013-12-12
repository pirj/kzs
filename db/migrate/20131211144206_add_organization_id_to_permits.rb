class AddOrganizationIdToPermits < ActiveRecord::Migration
  def change
    add_column :permits, :organization_id, :integer
  end
end
