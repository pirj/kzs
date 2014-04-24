class Tasks::Api::TasksController < ResourceController
  layout nil

  has_scope :for_organization, only: [:index]

  respond_to :json

  def index
    super do |success|
      success.json { render json: collection_as_json }
    end
  end

  def create
    @task = Tasks::Task.new(mapped_post_params).tap do |task|
      task.organization = current_user.organization
      # заглушка на первое время,чтобы не выключать валидации в модели
      task.approvers << User.where(organization_id: current_user.organization.id).first
      task.executors << User.where(organization_id: current_user.organization.id).last
    end
    super
  end


  private

  def collection_as_json
    {
        :data => collection.map do |task|
                  {
                      id: task.id,
                      title: task.title,
                      description: task.text,
                      start_date: task.started_at.localtime.strftime("%d-%m-%Y"),
                      duration: days_duration_for(task)
                  }
                end
    }
  end

  def days_duration_for(task)
    (task.finished_at - task.started_at).to_i/1.day
  end

  # преобразуем параметры пришедшие из клиентского js в наши собственные
  # по причине использования чужой библиотеки, не можем изменить клиентские параметры задачи
  def mapped_post_params
    p = permitted_post_params
    p[:text] = p.delete(:description.to_s)
    p[:finished_at] = p.delete(:end_date.to_s)
    p[:started_at] = p.delete(:start_date.to_s)
    p
  end


  def post_params
    params[:tasks_task]
  end


  # выбираем только разрешенные атрибуты из пришедших параметров
  def permitted_post_params
    permitted = [:end_date, :start_date, :title, :description]
    post_params.select { |k,v| permitted.include?(k.to_sym) }
  end

end
