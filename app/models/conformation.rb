class Conformation < ActiveRecord::Base
  attr_accessible :document_id, :user_id, :comment, :conformed

  validates :comment, presence: {message: 'Коментарий обязателен при отказе согласования.'}, if: lambda {conformed == false}
  validates :document_id, presence: true
  validates :user_id, presence: true

  belongs_to :document
  belongs_to :user
end
