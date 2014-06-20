class Notification < ActiveRecord::Base
  attr_accessible :user_id, :user, :changer_id, :changer, :message

  belongs_to :notifiable, polymorphic: true, counter_cache: true
  belongs_to :user
  belongs_to :changer, class_name: 'User', foreign_key: 'changer_id'
end