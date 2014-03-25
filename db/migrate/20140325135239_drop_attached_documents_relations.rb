class DropAttachedDocumentsRelations < ActiveRecord::Migration
  def up
    drop_table :attached_documents_relations
  end

  def down
    create_table :attached_documents_relations do |t|
      t.integer :document_id
      t.integer :attached_document_id
    end
  end
end
