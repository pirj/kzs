class AddStateToTasksTasks < ActiveRecord::Migration
  def change
    add_column :tasks_tasks, :state, :string
  end
end
