class AddSystemToUsers < ActiveRecord::Migration
  def change
    add_column :users, :sys_user, :boolean, :default => false
  end
  
end
