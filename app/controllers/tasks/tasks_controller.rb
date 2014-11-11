class Tasks::TasksController < ApplicationController
  include Tasks::NotificationsController

  layout 'sakeff'

  before_filter :subtask, only: [:show]
  before_filter :check_and_store_user_id

  # has_scope :per, default: 10, only: [:index]
  has_scope :for_organization, only: [:index]

  inherit_resources
  respond_to :js, :json, :html

  helper_method :mapped_resource, :collection_path

  def list
  end

  def show
    # Clear notifications
    @task = Tasks::Task.find(params[:id])
    @task.clear_notifications for: current_user

    super
  end

  def new
    @task = Tasks::Task.new
    # @task.checklists.build
    # @task.checklists.last.checklist_items.build
  end

  def create
    @task = Tasks::Task.new(params[:task]).tap do |task|
      task.organization = current_user.organization
      task.inspector = current_user
    end

    @task.updated_by = current_user.id
    super
  end

  def update
    @task = Tasks::Task.find(params[:id])
    @task.organization ||= current_user.organization
    @task.inspector = current_user
    @task.updated_by = current_user.id

    @task.checklists.each do |c|
      c.updated_by = current_user.id
    end

    super
  end
  
  def check_and_store_user_id
    unless session[:user_id]
      if params[:user_id] && User.exists?(params[:user_id])
        session[:user_id] = params[:user_id]
      else
        raise Exception::UserNotFound
      end
    end
  end

  private

  def collection_url
    tasks_path
  end

  def collection_path
    tasks_path
  end

  def resource_url
    task_path(resource)
  end

  def subtask
    @subtask ||= Tasks::Task.new(:parent_id => resource.id)
  end


end
