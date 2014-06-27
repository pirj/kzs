class Tasks::NotificationSerializer < ActiveModel::Serializer
  attributes :user,
            :message,

  def user
    object.user.first_name_with_last_name
  end
end
