class ChangeIssuedInDailyPasses < ActiveRecord::Migration
  def up
    remove_column :daily_passes, :issued
    add_column :daily_passes, :issued, :date
  end

  def down
    remove_column :daily_passes, :issued
    add_column :daily_passes, :issued, :string
  end
end
