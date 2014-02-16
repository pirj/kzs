class AddHasRussianRegisterSnToVehicle < ActiveRecord::Migration
  def change
    add_column :vehicles, :has_russian_register_sn, :boolean, default: true
  end
end
