class CreateTasksTaskTaskExecutors < ActiveRecord::Migration
  def change
    create_table :tasks_tasks_executors, id: false do |t|
      t.integer :task_id, null: false
      t.integer :user_id, null: false
    end
  end
end
