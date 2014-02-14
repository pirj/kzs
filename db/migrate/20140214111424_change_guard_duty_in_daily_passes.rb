class ChangeGuardDutyInDailyPasses < ActiveRecord::Migration
  def up
    remove_column :daily_passes, :guard_duty
    add_column :daily_passes, :guard_duty_id, :integer
  end

  def down
    remove_column :daily_passes, :guard_duty_id
    add_column :daily_passes, :guard_duty, :string
  end
end
