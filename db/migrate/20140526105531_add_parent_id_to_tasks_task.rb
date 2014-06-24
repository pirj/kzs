class AddParentIdToTasksTask < ActiveRecord::Migration
  def change
    add_column :tasks_tasks, :parent_id, :integer
  end
end
