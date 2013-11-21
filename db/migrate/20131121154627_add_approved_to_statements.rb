class AddApprovedToStatements < ActiveRecord::Migration
  def change
    add_column :statements, :approved, :boolean, :default => false
    add_column :statements, :approved_date, :datetime
    add_column :statements, :date, :datetime
    add_column :statements, :sn, :string
    add_column :statements, :approver_id, :integer
  end
end
