class NotificationMailer < ActionMailer::Base
  default from: "from@example.com"

  def notification user
    @user = user
    mail to: 'vladimir.krivchenko@gmail.com', subject: 'Notification!'
  end
end
