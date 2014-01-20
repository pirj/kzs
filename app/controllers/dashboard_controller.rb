class DashboardController < ApplicationController
  layout "dashboard"
  def index
    @desktop = UserDesktopConfiguration.find_by_user_id(current_user.id)
  end
  
  def save_desktop_configuration
    UserDesktopConfiguration.create!(:user_id => current_user.id, :desktop_conf => params[:desktop_conf])
  end
end
