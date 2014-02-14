class AddHasRussianRegisterSnToDailyPasses < ActiveRecord::Migration
  def change
    add_column :daily_passes, :has_russian_register_sn, :boolean, default: true
  end
end
