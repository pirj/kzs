class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :authenticate_user!
  
  def access_denied(exception)
    redirect_to root_path, :alert => t('access_denied')
  end
  
  
  private

  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

  def current_organization
    current_user.organization
  end

  # Referenced in /app/models/ability.rb
  # Referenced in /app/controllers/documents/*
  def ability_for(state)
    "assign_#{state}_state".to_sym
  end

  unless Rails.application.config.consider_all_requests_local
    rescue_from ActionController::RoutingError, ActionController::UnknownController, ::AbstractController::ActionNotFound, ActiveRecord::RecordNotFound, with: lambda { |exception| render_error 404, exception }
  end

  private
  def render_error(status, exception)
    respond_to do |format|
      format.html { render template: "errors/error_#{status}", layout: 'application', status: status }
      format.all { render nothing: true, status: status }
    end
  end


end
