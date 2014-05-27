class DropTableTasksTasksInspectors < ActiveRecord::Migration
  def up
    drop_table :tasks_tasks_inspectors
  end

  def down
    create_table :tasks_tasks_inspectors, id: false do |t|
      t.integer :task_id, null: false
      t.integer :user_id, null: false
    end
  end
end
