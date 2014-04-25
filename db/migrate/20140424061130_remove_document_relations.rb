class RemoveDocumentRelations < ActiveRecord::Migration
  def up
    drop_table :document_relations
  end

  def down
    # Support for DocumentRelations is gone
    fail ActiveRecord::IrreversibleMigration, 'DocumentRelations are gone, as they serve no use.'
  end
end
