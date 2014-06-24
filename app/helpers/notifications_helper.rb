module NotificationsHelper

  # TODO-justvitalius: выключил отправку по причине нестабильной работы private_pub на продакшене
  # создает закрытый канал между пользователем и сервером
  def subscribe_to_sidebar_notifications
    # subscribe_to("/notifications/update/#{current_user.id}")+
    # javascript_tag do
    #   raw "PrivatePub.subscribe('/notifications/update/#{current_user.id}', function(data, channel){ new NotificationView(data) })"
    # end
  end


end