class RenameTaskAndAddBodyToTasks < ActiveRecord::Migration
  def change
    rename_column :tasks, :task, :title
    add_column :tasks, :body, :text
  end
end
