class AddFieldsToDailyPasses < ActiveRecord::Migration
  def change
    add_column :daily_passes, :id_series, :integer
    add_column :daily_passes, :id_number, :integer
    add_column :daily_passes, :auto_mark, :string
    add_column :daily_passes, :auto_model, :string
    add_column :daily_passes, :lp_s1, :string
    add_column :daily_passes, :lp_s2, :string
    add_column :daily_passes, :lp_s3, :string
    add_column :daily_passes, :lp_n, :integer
    add_column :daily_passes, :lp_r, :integer
  end
end
