class Conformation < ActiveRecord::Base
  attr_accessible :document, :user, :comment, :conformed

  belongs_to :documents
  belongs_to :users
end
