class AddUpdatedByToTasksChecklists < ActiveRecord::Migration
  def change
    add_column :tasks_checklists, :updated_by, :integer
  end
end
