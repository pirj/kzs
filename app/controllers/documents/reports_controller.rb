class Documents::ReportsController < ResourceController
  include Documents::AccountableController

  layout 'base'
  actions :all, except: [:index]

  helper_method :orders_collection_for_select

  def copy
    @parent_report = end_of_association_chain.find(params[:id])

    @report = end_of_association_chain.new
    @report.document = @parent_report.document.safe_clone

    render action: :new
  end

  def show
    show! { @report = Documents::ShowDecorator.decorate(resource) }
  end

  def create
    @report = Documents::Report.new(params[:documents_report])
    @report.sender_organization = current_organization
    @report.recipient_organization = @report.order.sender_organization
    @report.executor ||= current_user
    @report.creator = current_user
    create!
  end


  private

  def orders_collection_for_select
    @orders_collection_for_select ||= Documents::Order.with_state('approved')
  end
end