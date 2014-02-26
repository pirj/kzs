class CreateDocumentConformers < ActiveRecord::Migration
  def change
    create_table :documents_users, id: false do |t|
      t.integer :document_id, null: false
      t.integer :user_id, null: false
    end
  end

end
