class ChangedRegionNumberFieldType < ActiveRecord::Migration
  def up
    remove_column :daily_passes, :lp_r
    add_column :daily_passes, :lp_r, :string
    remove_column :vehicles, :sn_region
    add_column :vehicles, :sn_region, :string
  end

  def down
    remove_column :daily_passes, :lp_r
    add_column :daily_passes, :lp_r, :integer
    remove_column :vehicles, :sn_region
    add_column :vehicles, :sn_region, :integer
  end
end
