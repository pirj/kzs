class ChangeInnTypeForOrganizations < ActiveRecord::Migration
  def change
    change_column :organizations, :inn, :string
  end
end
