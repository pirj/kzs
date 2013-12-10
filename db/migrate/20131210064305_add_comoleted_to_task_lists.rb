class AddComoletedToTaskLists < ActiveRecord::Migration
  def change
    add_column :task_lists, :completed, :boolean, :default => false
  end
end
