class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.integer :order_id, null: false

      t.timestamps
    end

    add_index :reports, :order_id
  end
end
