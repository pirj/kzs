class Documents::DocumentsController < ResourceController
  layout 'base'
  actions :index

  def index
    @documents = Documents::ListDecorator.decorate(collection.includes(:sender_organization, :recipient_organization), with: Documents::ListShowDecorator)
  end


end