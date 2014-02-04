class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.decimal :phone, precision: 11, scale: 0
      t.string :position
      t.string :organization
      t.string :division
      t.text :info
      t.integer :access_level
      t.string :email
      t.attachment :photo
      t.string :dob
      t.string :permit
      t.integer :work_status

      t.timestamps
    end
  end
end

