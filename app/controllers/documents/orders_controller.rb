class Documents::OrdersController < ResourceController
  include Documents::Base

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
    end
  end

  def show
    show!{
      @order = Documents::ShowDecorator.decorate(resource)
    }
  end

end