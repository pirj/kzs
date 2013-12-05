class AddDocumentIdToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :document_id, :integer
    add_column :tasks, :executor_organization_id, :integer
    add_column :tasks, :sender_organization_id, :integer
    add_column :tasks, :deadline, :datetime
    add_column :tasks, :executor_id, :integer
    add_column :tasks, :creator_id, :integer
    add_column :tasks, :approver_id, :integer
    add_column :tasks, :executor_comment, :text
  end
end
