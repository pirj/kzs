class AddExecutorIdAndInspectorIdToTasksTasks < ActiveRecord::Migration
  def change
    add_column :tasks_tasks, :executor_id, :integer
    add_column :tasks_tasks, :inspector_id, :integer
  end
end
