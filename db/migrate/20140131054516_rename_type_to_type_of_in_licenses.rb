class RenameTypeToTypeOfInLicenses < ActiveRecord::Migration
  def up
    add_column :licenses, :type_of, :string
  end
end
