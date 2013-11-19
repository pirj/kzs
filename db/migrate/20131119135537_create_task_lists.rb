class CreateTaskLists < ActiveRecord::Migration
  def change
    create_table :task_lists do |t|
      t.integer :statement_id

      t.timestamps
    end
  end
end
