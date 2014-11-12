module LeftMenuSakeffHelper

  def left_menu_notification_for(type)
    case type.to_s
    when 'control' then control_dashboard_css
    when 'units' then left_menu_notifications[1]
    when 'messages' then left_menu_notifications[2]
    when 'documents' then left_menu_notifications[3]
    end
  end

  def users_root_path
    "#{domain_name}/dashboard"
  end

  def control_dashboard_path
    "#{domain_name}/control/dashboard"
  end

  def units_path
    "#{domain_name}/units"
  end

  def messages_broadcast_path
    "#{domain_name}/messages/broadcast"
  end

  def dialogues_path
    "#{domain_name}/dialogues"
  end

  def scope_permits_path(type)
    "#{domain_name}/permits/by_type/#{type.to_s}"
  end

  def tasks_module_path
    "tasks"
  end

  def destroy_user_session_path
    "#{domain_name}/users/sign_out"
  end

  def documents_path
    "#{domain_name}/documents"
  end

private

  def left_menu_notifications
    session[:notifications]
  end

  def control_dashboard_css
    (left_menu_notifications[0].to_i == 1)? 'badge-green m-important' : 'badge-red m-important'
  end

  def domain_name
    "http://localhost:3000/" if Rails.env.development?
  end

end