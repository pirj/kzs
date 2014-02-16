class RemoveDocumentIdFromTaskLists < ActiveRecord::Migration
  def change
    remove_column :task_lists, :document_id
  end

end
