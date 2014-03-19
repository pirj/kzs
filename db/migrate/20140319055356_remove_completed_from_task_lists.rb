class RemoveCompletedFromTaskLists < ActiveRecord::Migration
  def up
    remove_column :task_lists, :completed
  end

  def down
    add_column :task_lists, :completed, :boolean
  end
end
