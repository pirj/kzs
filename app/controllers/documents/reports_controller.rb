class Documents::ReportsController < ResourceController
  include Documents::AccountableController

  layout 'base'
  actions :all, except: [:index]

  helper_method :orders_collection_for_select

  def new
    @report = Documents::Report.new
    if params[:order_id].present?
      order = Documents::Order.find(params[:order_id])
      @report.order = order
    end
    new!
  end

  def copy
    initial = end_of_association_chain.find(params[:id])
    @report = initial.amoeba_dup
    render action: :new
  end

  def show
    show! do
      @report = Documents::ShowDecorator.decorate(resource)
      order = Documents::Order.find(resource.order_id)
      tasks = order.tasks.order('created_at ASC')
      @tasks = Tasks::ListDecorator.decorate tasks,
                                             with: Tasks::ListShowDecorator
    end
  end

  def create
    @report = Documents::Report.new(params[:documents_report])
    @report.sender_organization = current_organization
    @report.recipient_organization = @report.order.sender_organization
    @report.executor ||= current_user
    @report.creator = current_user
    super
  end

  def update
    resource.creator = current_user
    super
  end

  private

  def orders_collection_for_select
    @orders_collection_for_select ||= Documents::Order
                                      .with_state('sent')
                                      .to(current_organization.id)
  end
end
