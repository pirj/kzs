# coding: utf-8
class Documents::OrdersController < ResourceController
  include Documents::AccountableController

  layout 'base'
  actions :all, except: [:index]

  helper_method :history

  # def copy
  #   initial = end_of_association_chain.find(params[:id])
  #   @order = initial.amoeba_dup
  #       render action: :new
  # end

  # TODO: @justvitalius why do we get Report by id in Orders controller?
  # в reports#show на 37 строке линк на данный экшн
  def reject
    report = Documents::Report.find(params[:id])
    parent_order = report.order
    @order = Documents::Order.new
    @order.approver = parent_order.approver
    @order.recipient_organization = report.sender_organization
    @order.sender_organization = current_user.organization
    @order.title = "В ответ на Акт №#{report.serial_number}"
    @order.build_task_list
    @order.task_list.tasks.build

    # create history for orders
    unless parent_order.conversation_id
      parent_order.create_conversation
      parent_order.save!
    end

    @order.conversation = parent_order.conversation
  end

  def new
    @order = Documents::Order.new.tap do |order|
      order.build_document
      order.build_task_list
      order.task_list.tasks.build
    end
    new!
  end

  def show
    @order = Documents::ShowDecorator.decorate(resource)
    tasks = @order.tasks.order('created_at ASC')
    @tasks = Tasks::ListDecorator.decorate tasks,
                                           with: Tasks::ListShowDecorator

    # TODO-tagir: удали все переменные,которые не используешь во вьюхе
    @task_list = @order.task_list
    @newtasks = @task_list.tasks
    show!
  end

  def create
  @order = Documents::Order.new(params[:documents_order]).tap do |order|
    order.sender_organization = current_organization
    order.creator = current_user
    order.executor ||= current_user
    order.build_task_list if order.task_list.blank?
    order.task_list.tasks.build if order.task_list.blank?
  end
  super
  end

  def update
    resource.creator = current_user
    super
  end

  private

  def history
    @history ||= resource.history_for(current_organization.id)
  end
end
