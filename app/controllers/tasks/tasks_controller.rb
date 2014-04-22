class Tasks::TasksController < InheritedResources::Base
  layout 'base'

  def index
    @tasks = Tasks::Task.for_org(current_organization).page(params[:page]).per(10)
  end

  def create
    @task = Tasks::Task.create(params[:tasks_task])
    @task.organization_id = current_user.organization_id
    if @task.save
      redirect_to @task, :notice => 'Задача успешно поставлена'
    else
      render :new
    end
  end

end
