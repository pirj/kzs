class Documents::ReportsController < ResourceController
  include Documents::AccountableController

  layout 'base'
  actions :all, except: [:index]

  helper_method :orders_collection_for_select

  def new
    @report = Documents::Report.new.tap do |report|
      report.build_document
      report.order_id = params[:order_id] if params[:order_id]
    end

    new!
  end

  def show
    @report = Documents::ShowDecorator.decorate(resource)
    order = Documents::Order.find(resource.order_id)
    tasks = order.tasks.order('created_at ASC')
    @tasks = Tasks::ListDecorator.decorate tasks,
                                           with: Tasks::ListShowDecorator
    show!
  end

  def create
    @report = Documents::Report.new(params[:documents_report]).tap do |report|
      report.sender_organization = current_organization
      report.creator = current_user
      report.executor ||= current_user
      if report.order # TODO: Возможно ли создание акта без Распоряжения?
        report.recipient_organization = report.order.sender_organization
      end
    end

    if @report.save

      # TODO: This should go away on the next round
      if @report.order
        story = Documents::History.new @report.order
        story.add @report
      end

      resource.transition_to!(params[:transition_to], default_metadata)
      redirect_to documents_path
    else
      render action: 'new'
    end
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
