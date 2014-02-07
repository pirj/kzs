class CreateDocs < ActiveRecord::Migration
  def change
    create_table :docs do |t|
      t.string :title, null: false
      t.string :serial_number
      t.text :body
      t.boolean :confidential, null: false, default: false
      t.integer :sender_organisation_id, null: false
      t.integer :reciever_organisation_id, null: false
      t.integer :approver_id, null: false
      t.integer :executor_id, null: false
      t.string :status_cache
      t.string :accountable_type, null: false
      t.integer :accountable_id, null: false

      t.timestamps
    end

    add_index :docs, :approver_id
    add_index :docs, :executor_id
    add_index :docs, :sender_organisation_id
    add_index :docs, :reciever_organisation_id
    add_index :docs, [:accountable_id, :accountable_type], unique: true

  end
end
