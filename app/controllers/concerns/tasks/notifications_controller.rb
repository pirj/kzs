module Tasks::NotificationsController
  extend ActiveSupport::Concern

  included do
    after_filter :send_notifications_to_all_users, except: [:index, :subtask, :edit, :new]
  end

  def send_notifications_to_all_users
    current_organization.users.each do |user|
      data = Tasks::Task.notifications_for(user).count
      PrivatePub.publish_to "/notifications/update/#{user.id}", notifications: {tasks_module: data}
    end
  end
end