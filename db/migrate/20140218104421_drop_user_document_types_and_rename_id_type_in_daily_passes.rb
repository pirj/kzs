class DropUserDocumentTypesAndRenameIdTypeInDailyPasses < ActiveRecord::Migration
  def up
  	drop_table :user_document_types
  	rename_column :daily_passes, :id_type, :document_type
  end

  def down
  	rename_column :daily_passes, :document_type, :id_type
  	create_table :user_document_types do |t|	
  		t.column :title, :string
  		t.timestamp
  	end	
  end
end
