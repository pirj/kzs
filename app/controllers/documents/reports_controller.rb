class Documents::ReportsController < ResourceController
  include Documents::Base

  layout 'base'
  actions :all, except: [:index]

  before_filter :available_orders

  def copy
    @parent_report = end_of_association_chain.find(params[:id])

    @report = end_of_association_chain.new
    @report.document = @parent_report.document.safe_clone

    render action: :new
  end

  def new
    new! do
      @report.sender_organization_id = current_user.organization_id
    end
  end

  def show
    show!{
      @report = Documents::ShowDecorator.decorate(resource)
    }
  end

  def create
    create!{
      @report.recipient_organization = sender_organization_by_order
    }
  end


  def update
    update!{
      @report.recipient_organization = sender_organization_by_order
    }
  end

  protected
  def available_orders
    @available_orders = Document.orders.approved
  end

  def sender_organization_by_order
    order = Document.where(id: params[:documents_report][:order_id]).includes(:sender_organization).first
    order.nil?? nil : order.sender_organization
  end
end