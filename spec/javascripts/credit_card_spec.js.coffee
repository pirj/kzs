describe 'NotificationView', ->
  it 'return data', ->
    notification = new NotificationView(
      notifications:
        tasks_module: 4
    )

    expect(notification.render()).toBe(4)
