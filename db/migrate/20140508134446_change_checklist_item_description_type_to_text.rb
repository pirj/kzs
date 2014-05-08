class ChangeChecklistItemDescriptionTypeToText < ActiveRecord::Migration
  def up
    change_column :tasks_checklist_items, :description, :text
  end

  def down
    change_column :tasks_checklist_items, :description, :string
  end
end
