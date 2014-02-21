class RemoveNotNullConstraintFromDocuments < ActiveRecord::Migration
  def change
    change_column :documents, :recipient_organization_id, :integer, :null => true
  end
end
