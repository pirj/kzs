class ChangeTasksTable < ActiveRecord::Migration
  def up
    remove_column :tasks_tasks, :organization_id
    remove_column :tasks_tasks, :executor_id
    remove_column :tasks_tasks, :inspector_id
    remove_column :tasks_tasks, :updated_by
    add_column :tasks_tasks, :organization_id, :uuid
    add_column :tasks_tasks, :executor_id, :uuid
    add_column :tasks_tasks, :inspector_id, :uuid
    add_column :tasks_tasks, :updated_by, :uuid
  end
  
  def down
    remove_column :tasks_tasks, :organization_id
    remove_column :tasks_tasks, :executor_id
    remove_column :tasks_tasks, :inspector_id
    remove_column :tasks_tasks, :updated_by
    add_column :tasks_tasks, :organization_id, :integer
    add_column :tasks_tasks, :executor_id, :integer
    add_column :tasks_tasks, :inspector_id, :integer
    add_column :tasks_tasks, :updated_by, :integer
  end
end
