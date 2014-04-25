class Notification < ActiveRecord::Base
  attr_accessible :user_id, :document_id

  belongs_to :document
  belongs_to :user
end