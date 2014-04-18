class NotificationMailer < ActionMailer::Base
  default from: "test@cyclonelabs.com"

  def notification user, mail_to
    @user = user
    mail to: mail_to, subject: 'Notification!'
  end
end
