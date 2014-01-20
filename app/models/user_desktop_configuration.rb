class UserDesktopConfiguration < ActiveRecord::Base
  attr_accessible :desktop_conf, :user_id

  serialize :desktop_conf, Hash
end
