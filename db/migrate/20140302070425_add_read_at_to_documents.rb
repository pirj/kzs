class AddReadAtToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :read_at, :timestamp
  end
end
