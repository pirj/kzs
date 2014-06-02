class Tasks::TasksController < ResourceController
  layout 'base'

  before_filter :subtask, only: [:show]

  has_scope :per, default: 10, only: [:index]
  has_scope :for_organization, only: [:index]

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

  #def mapped_resource
  #  {
  #      id: resource.id,
  #      title: resource.title,
  #      description: resource.text,
  #      start_date: resource.started_at.try(:localtime).try(:strftime, "%d-%m-%Y"),
  #      duration: days_duration_for(resource)
  #  }.to_json.html_safe
  #end
  #
  #def days_duration_for(task)
  #  (task.finished_at - task.started_at).to_i/1.day if task.started_at && task.finished_at
  #end

end
