class ChangeDocumentsDeadlineField < ActiveRecord::Migration
  def change
    remove_column :documents, :deadline
    add_column :documents, :deadline, :datetime
  end

  def down
    remove_column :documents, :deadline
    add_column :documents, :deadline
  end
end
