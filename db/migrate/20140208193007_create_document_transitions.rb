class CreateDocumentTransitions < ActiveRecord::Migration
  def change
    create_table :document_transitions do |t|
      t.string :to_state
      t.text :metadata, default: "{}"
      t.integer :sort_key
      t.integer :doc_id
      t.datetime :created_at
    end

    add_index :document_transitions, :doc_id
    add_index :document_transitions, [:sort_key, :doc_id], unique: true
  end
end
