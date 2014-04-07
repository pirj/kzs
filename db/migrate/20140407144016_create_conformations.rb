class CreateConformations < ActiveRecord::Migration
  def change
    create_table :conformations do |t|
      t.integer :document_id
      t.integer :user_id
      t.boolean :conformed
      t.string :comment
    end

    add_index :conformations, [:document_id, :user_id], :unique => true
  end
end
