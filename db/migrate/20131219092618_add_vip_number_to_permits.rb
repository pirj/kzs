class AddVipNumberToPermits < ActiveRecord::Migration
  def change
    add_column :permits, :vip_number, :string
  end
end
