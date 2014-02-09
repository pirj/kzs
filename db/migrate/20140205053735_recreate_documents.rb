class RecreateDocuments < ActiveRecord::Migration
  def up
    puts 'This migrations is irreversible as it replaces the documents table.'

    drop_table :documents

    create_table :documents do |t|
      t.string  :title, null: false
      t.string  :serial_number
      t.text    :body
      t.boolean :confidential, null: false, default: false
      t.integer :sender_organization_id, null: false
      t.integer :recipient_organization_id, null: false
      t.integer :approver_id, null: false
      t.integer :executor_id, null: false
      t.string  :state
      t.string  :accountable_type, null: false
      t.integer :accountable_id, null: false

      t.timestamps
    end

    add_index :docs, :approver_id
    add_index :docs, :executor_id
    add_index :docs, :sender_organization_id
    add_index :docs, :recipient_organization_id
    add_index :docs, [:accountable_id, :accountable_type], unique: true

  end

  def down
    # ATTENTION! THIS MIGRATION IS IRRVERSIBLE
    # AS IT DROPS THE OLD DOCUMENTS TABLE
    # AND REPLACES IT WITH THE NEW ONE
    raise ActiveRecord::IrreversibleMigration
  end
end
