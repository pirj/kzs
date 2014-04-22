class Tasks::TasksController < ResourceController
  layout 'base'

  has_scope :per, default: 10, only: [:index]
  has_scope :for_organization, only: [:index]

  def create
    @task = Tasks::Task.new(params[:tasks_task]).tap do |task|
      task.organization = current_user.organization
    end
    super
  end

  def update
    @task = Tasks::Task.find(params[:id])
    @task.organization ||= current_user.organization
    super
  end


  private

  def collection_url
    tasks_path
  end

  def resource_url
    task_path(resource)
  end

end
