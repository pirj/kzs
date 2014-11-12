class Tasks::NotificationSerializer < ActiveModel::Serializer
  attributes :user,
            :message,

  def user
    object.user.first_name_with_last_name if object.user
  end
end
