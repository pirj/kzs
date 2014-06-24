class AddFinishedAtToTasksChecklistItems < ActiveRecord::Migration
  def change
    add_column :tasks_checklist_items, :finished_at, :datetime
  end

end
