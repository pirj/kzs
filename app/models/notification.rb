class Notification < ActiveRecord::Base
  attr_accessible :user_id, :user, :changer_id, :changer, :message

  belongs_to :notifiable, polymorphic: true
  belongs_to :user
end