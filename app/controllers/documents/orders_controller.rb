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


  def new
    new! do
      @order.sender_organization_id = current_user.organization_id
      @order.build_task_list
      @order.task_list.tasks.build
    end
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
    @order.creator = current_user
    super
  end

  def update

    update!{
      @order.creator = current_user
    }
  end
end
