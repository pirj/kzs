class NotificationMailer < ActionMailer::Base
  default from: "sake@cyclonelabs.net"

  def document_changed user, mail_to
    @user = user
    mail to: mail_to, subject: 'Notification!'
  end
end
