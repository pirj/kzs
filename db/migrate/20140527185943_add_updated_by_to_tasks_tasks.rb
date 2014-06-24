class AddUpdatedByToTasksTasks < ActiveRecord::Migration
  def change
    add_column :tasks_tasks, :updated_by, :integer
  end
end
