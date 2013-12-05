class AddDocumentIdToTaskLists < ActiveRecord::Migration
  def change
    add_column :task_lists, :document_id, :integer
  end
end
