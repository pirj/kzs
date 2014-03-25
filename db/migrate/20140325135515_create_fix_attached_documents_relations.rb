class CreateFixAttachedDocumentsRelations < ActiveRecord::Migration
  def change
    create_table :attached_documents_relations do |t|
      t.integer :document_id
      t.integer :attached_document_id
    end
  end
end
