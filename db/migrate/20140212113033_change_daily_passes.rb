class ChangeDailyPasses < ActiveRecord::Migration
  def change
    add_column :daily_passes, :register_sn, :string
    remove_columns :daily_passes, :lp_s1, :lp_s2, :lp_s3, :lp_n
  end
end
