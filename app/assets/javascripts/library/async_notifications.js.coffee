PrivatePub.subscribe "/notifications/update", (data, channel) ->
  new NotificationView(data)