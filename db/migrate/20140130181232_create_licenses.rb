class CreateLicenses < ActiveRecord::Migration
  def change
    create_table :licenses do |t|
      t.string :type
      t.string :number
      t.date :issuance
      t.date :deadline
      t.string :issued_by

      t.timestamps
    end
  end
end
