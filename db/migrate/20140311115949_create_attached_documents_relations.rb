class CreateAttachedDocumentsRelations < ActiveRecord::Migration
  def change
    create_table :attached_documents_relations do |t|
      t.integer :document_id
      t.integer :attached_document_id
      t.boolean :temp
      t.boolean :to_delete

      t.timestamps
    end
  end
end
