class ChangeUserDesktopConfigurations < ActiveRecord::Migration
  def up
    change_column :user_desktop_configurations, :desktop_conf, :text
  end

  def down
  end
end
