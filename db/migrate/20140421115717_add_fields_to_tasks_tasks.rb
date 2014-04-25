class AddFieldsToTasksTasks < ActiveRecord::Migration
  def change
    add_column :tasks_tasks, :organization_id, :integer
  end
end
