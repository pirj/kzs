class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate_user!

  helper_method :current_organization, :can_apply_state?, :ability_for

  def access_denied(exception)
    redirect_to root_path, alert: t('access_denied')
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
    "apply_#{state}".to_sym
  end

  def can_apply_state?(state, accountable)
    ability_name = ability_for(state)
    can?(ability_name, accountable)
  end

  unless Rails.application.config.consider_all_requests_local
    rescue_from *renderable_exceptions, with: lambda { |exception| render_error 404, exception }
  end

  private

  def render_error(status, exception)
    respond_to do |format|
      format.html { render template: "errors/error_#{status}", layout: 'application', status: status }
      format.all { render nothing: true, status: status }
    end
  end

  def renderable_exceptions
    [ActionController::RoutingError,
     ActionController::UnknownController,
     ::AbstractController::ActionNotFound,
     ActiveRecord::RecordNotFound]
  end
end
