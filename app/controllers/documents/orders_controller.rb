class Documents::OrdersController < ResourceController
  include Documents::AccountableController

  layout 'base'
  actions :all, except: [:index]

  def copy
    @parent_order = end_of_association_chain.find(params[:id])
    @order = @parent_order.clone
    @order.document = @parent_order.document.safe_clone

    render action: :new
  end


  def show
    show!{
      @tasks = Tasks::ListDecorator.decorate(@order.tasks.order('created_at ASC'), with: Tasks::ListShowDecorator)
      @order = Documents::ShowDecorator.decorate(resource)
    }
  end

  def create
    @order = Documents::Order.new(params[:documents_order])
    @order.sender_organization = current_organization
    @order.executor ||= current_user
    create!
  end
end
