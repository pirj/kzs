class OrdersConversation < ActiveRecord::Base
  has_many :orders, class_name: 'Documents::Order', foreign_key: :conversation_id

end
