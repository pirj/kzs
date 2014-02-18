class ChangeIdFieldsForDailyPasses < ActiveRecord::Migration
  def up
    remove_column :daily_passes, :id_series
    add_column :daily_passes, :id_series, :string
    remove_column :daily_passes, :id_number
    add_column :daily_passes, :id_number, :string
  end

  def down
    remove_column :daily_passes, :id_series
    add_column :daily_passes, :id_series, :integer
    remove_column :daily_passes, :id_number
    add_column :daily_passes, :id_number, :integer
  end
end
