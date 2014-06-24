class CreateTasksChecklists < ActiveRecord::Migration
  def up
    create_table :tasks_checklists do |t|
      t.string :name
      t.integer :task_id

      t.timestamps
    end
  end

  def down
    drop_table :tasks_checklists
  end
end
