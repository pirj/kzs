class UserDesktopConfiguration < ActiveRecord::Base
  attr_accessible :desktop_conf, :user_id

  #serialize :desktop_conf, Array

  def desktop_conf
    JSON.load(self[:desktop_conf])
  end
end
