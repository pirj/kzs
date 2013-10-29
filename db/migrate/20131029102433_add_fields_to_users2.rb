class AddFieldsToUsers2 < ActiveRecord::Migration
  def change
    add_column :users, :id_type, :integer
    add_column :users, :id_sn, :string
    add_column :users, :id_issue_date, :date
    add_column :users, :id_issuer, :string
    add_column :users, :alt_name, :string
  end
end
