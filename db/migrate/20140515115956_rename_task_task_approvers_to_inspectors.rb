class RenameTaskTaskApproversToInspectors < ActiveRecord::Migration
  def up
    rename_table :tasks_tasks_approvers, :tasks_tasks_inspectors
  end

  def down
    rename_table :tasks_tasks_inspectors, :tasks_tasks_approvers
  end
end
