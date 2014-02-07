class Documents::OrdersController < ResourceController
  layout 'base'
  actions :all, except: [:index]
end