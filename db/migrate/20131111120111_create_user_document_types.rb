class CreateUserDocumentTypes < ActiveRecord::Migration
  def change
    create_table :user_document_types do |t|
      t.string :title

      t.timestamps
    end
  end
end
