class CreateUserDesktopConfigurations < ActiveRecord::Migration
  def change
    create_table :user_desktop_configurations do |t|
      t.integer :user_id
      t.string :desktop_conf

      t.timestamps
    end
  end
end
