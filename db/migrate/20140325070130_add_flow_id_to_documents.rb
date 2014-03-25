class AddFlowIdToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :flow_id, :integer
    add_index :documents, :flow_id
  end
end
