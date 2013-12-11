class AddWithCompletedTaskListToStatements < ActiveRecord::Migration
  def change
    add_column :statements, :with_completed_task_list, :boolean, :default => false
  end
end
