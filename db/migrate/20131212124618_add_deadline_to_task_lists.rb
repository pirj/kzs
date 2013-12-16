class AddDeadlineToTaskLists < ActiveRecord::Migration
  def change
    add_column :task_lists, :deadline, :datetime
  end
end
