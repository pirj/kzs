class Documents::MailsController < ResourceController
  layout 'base'
  actions :all, except: [:index]
end