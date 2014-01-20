class DashboardController < ApplicationController
  #TODO: bug with logout from dashboard layout.
  layout 'dashboard'
  def index

    #@desktop = UserDesktopConfiguration.find_by_user_id(current_user.id)
    @desktop = UserDesktopConfiguration.where(user_id: current_user.id).first_or_create!

    respond_to do |format|
      format.html
      format.json { render json: @desktop }
    end


  end
  
  def save_desktop_configuration
    #UserDesktopConfiguration.create(:user_id => current_user.id, :desktop_conf => params[:widgets])
    UserDesktopConfiguration.where(user_id: current_user.id).first.update_attributes(desktop_conf: params[:widgets] )
    render :nothing => true
  end
end
