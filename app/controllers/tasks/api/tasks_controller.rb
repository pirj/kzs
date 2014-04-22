class Tasks::Api::TasksController < ResourceController
  layout nil

  has_scope :for_organization, only: [:index]

  respond_to :json

  def create
    @task = Tasks::Task.new(params[:tasks_task]).tap do |task|
      task.organization = current_user.organization
    end
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
