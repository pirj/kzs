class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate_user!

  helper_method :current_organization, :can_apply_state?, :ability_for, :documents_important, :organizations

  def access_denied(exception)
    redirect_to root_path, alert: t('access_denied')
  end

  private

  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

  def documents_important
    @documents_important = Documents::ImportantDecorator.new(pure_important)
  end

  def pure_important
    Documents::Important.new(current_user, current_organization)
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

  def organizations
    @all_organizations ||= Organization.order('short_title ASC')
  end
  
  def after_sign_in_path_for(resource)
    session[:welcome] = true
    super
  end
  #current_user.domain_prefix

  unless Rails.application.config.consider_all_requests_local
    rescue_from *[ActionController::RoutingError,
                   ActionController::UnknownController,
                   ::AbstractController::ActionNotFound,
                   ActiveRecord::RecordNotFound], with: lambda { |exception| render_error 404, exception }
  end

  def render_error(status, exception)
    respond_to do |format|
      format.html { render template: "errors/error_#{status}", layout: 'application', status: status }
      format.all { render nothing: true, status: status }
    end
  end

end
