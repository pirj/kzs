class Documents::ReportsController < ResourceController
  include Documents::Base

  layout 'base'
  actions :all, except: [:index]
end