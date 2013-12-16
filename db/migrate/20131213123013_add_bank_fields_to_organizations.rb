class AddBankFieldsToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :bank_title, :string
     add_column :organizations, :bank_address, :string
    add_column :organizations, :bank_correspondent_account, :string
    add_column :organizations, :bank_bik, :string
    add_column :organizations, :bank_inn, :string
    add_column :organizations, :bank_kpp, :string
    add_column :organizations, :bank_okved, :string
    add_column :organizations, :organization_account, :string
  end
end
