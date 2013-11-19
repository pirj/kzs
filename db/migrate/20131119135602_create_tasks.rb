class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :task_list_id
      t.text :task
      t.boolean :completed, :default => false

      t.timestamps
    end
  end
end
