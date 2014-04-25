class CreateTasksTasks < ActiveRecord::Migration
  def change
    create_table :tasks_tasks do |t|
      t.string :title
      t.text :text
      t.datetime :started_at
      t.datetime :finished_at

      t.timestamps
    end
  end
end
