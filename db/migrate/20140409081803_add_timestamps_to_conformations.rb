class AddTimestampsToConformations < ActiveRecord::Migration
  def change
    add_column :conformations, :created_at, :datetime
    add_column :conformations, :updated_at, :datetime
  end
end
