class CreateDailyPasses < ActiveRecord::Migration
  def change
    create_table :daily_passes do |t|
      t.integer :permit_id
      t.string :last_name
      t.string :first_name
      t.string :middle_name
      t.string :id_type
      t.string :id_sn
      t.string :vehicle
      t.string :object
      t.string :person
      t.string :issued
      t.date :date
      t.string :guard_duty
      

      t.timestamps
    end
  end
end
