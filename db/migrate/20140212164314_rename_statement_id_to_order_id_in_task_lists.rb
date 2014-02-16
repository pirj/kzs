class RenameStatementIdToOrderIdInTaskLists < ActiveRecord::Migration
  def change
    rename_column :task_lists, :statement_id, :order_id
    add_index :task_lists, :order_id
  end
end
