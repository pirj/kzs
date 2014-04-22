class Tasks::TasksController < ResourceController
  layout 'base'

  # TODO-justvitalius: это надо переделать на соглашение самого inherited resources
  def index
    @tasks = Tasks::Task.for_organization(current_organization).page(params[:page]).per(10)
  end

  def create
    @task = Tasks::Task.new(params[:tasks_task])
    @task.organization = current_user.organization
    super do |success|
      success.html { redirect_to task_path(@task), notice: 'задача успешно поставлена' }
    end
  end

  def update
    super do |success, failure|
      success.html { redirect_to task_path(@task), notice: 'задача успешно обновлена' }
      failure.html { redirect_to edit_task_path(@task), notice: 'произошли ошибки обновления' }
    end
  end


end
