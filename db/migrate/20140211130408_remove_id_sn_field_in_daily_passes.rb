class RemoveIdSnFieldInDailyPasses < ActiveRecord::Migration
  def change
    remove_column :daily_passes, :id_sn
  end
end
