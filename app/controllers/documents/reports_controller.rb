class Documents::ReportsController < ResourceController
  layout 'base'
  actions :all, except: [:index]
end