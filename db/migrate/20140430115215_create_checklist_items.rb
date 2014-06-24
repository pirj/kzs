class CreateChecklistItems < ActiveRecord::Migration
  def up
    create_table :tasks_checklist_items do |t|
      t.string :name
      t.string :description
      t.boolean :checked
      t.integer :checklist_id

      t.timestamps
    end
  end

  def down
    drop_table :tasks_checklist_items
  end
end
