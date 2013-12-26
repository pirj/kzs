class AddAcceptedDateToStatements < ActiveRecord::Migration
  def change
    add_column :statements, :accepted_date, :datetime
    add_column :statements, :opened_date, :datetime
    add_column :statements, :sent_date, :datetime
    add_column :statements, :prepared_date, :datetime
    add_column :statements, :refuse_date, :datetime
  end
end
