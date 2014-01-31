class RenameTypeToTypeOfInLicenses < ActiveRecord::Migration
  def up
    rename_column :licenses, :typeof, :type_of
  end
end
