class Conformation < ActiveRecord::Base
  attr_accessible :document_id, :user_id, :comment

  belongs_to :documents
  belongs_to :users
end
