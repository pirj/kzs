class AddPermitIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :permit_id, :integer
  end
end
