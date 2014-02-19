class AddApprovedAtToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :approved_at, :timestamp
  end
end
