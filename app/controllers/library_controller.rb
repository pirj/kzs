class LibraryController < ApplicationController
  layout "library"
  before_filter :require_admin
  
  def library
  end
  
  private

  #
  def require_admin
    return if current_user.sys_user
    redirect_to root_path, :alert => I18n.t('access_denined')
  end
  
end
