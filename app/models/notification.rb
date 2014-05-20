class Notification < ActiveRecord::Base
  attr_accessible :user_id

  belongs_to :notifiable, polymorphic: true
  belongs_to :user
end