class CreateDocs < ActiveRecord::Migration
  def change
    create_table :docs do |t|
      t.string :title
      t.text :body
      t.integer :sender_organisation_id
      t.integer :reciever_organisation_id
      t.integer :approver_id
      t.integer :executor_id
      t.string :status_cache
      t.string :accountable_type
      t.integer :accountable_id

      t.timestamps
    end

    add_index :docs, :approver_id
    add_index :docs, :executor_id
    add_index :docs, :sender_organisation_id
    add_index :docs, :reciever_organisation_id
    add_index :docs, [:accountable_id, :accountable_type], unique: true

  end
end
