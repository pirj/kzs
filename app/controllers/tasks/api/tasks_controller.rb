class Tasks::Api::TasksController < ResourceController
  layout nil

  before_filter :permit_params, only: [:create, :update]
  has_scope :for_organization, only: [:index]
  respond_to :json

  def index
    super do |success|
      success.json { render json: collection_as_json }
    end
  end

  def create
    @task = Tasks::Task.new(params[:tasks_task]).tap do |task|
      task.organization = current_user.organization
      # заглушка на первое время,чтобы не выключать валидации в модели
      task.approvers << User.where(organization_id: current_user.organization.id).first
      task.executors << User.where(organization_id: current_user.organization.id).last
    end
    super
  end
  

  def update
    @task = Tasks::Task.find(params[:id])
    @task.organization ||= current_user.organization
    @task.approvers << User.where(organization_id: current_user.organization.id).first  if @task.approvers.blank?
    @task.executors << User.where(organization_id: current_user.organization.id).last   if @task.executors.blank?
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


  # преобразуем пришедшие параметры
  # пропускаем только то, что можно пропустить
  def permit_params
    permitted = [:end_date, :start_date, :title, :description]
    params[:tasks_task].reject! do |k,v|
      !permitted.include?(k.to_sym)
    end
    mapping_post_params
  end

  # преобразуем параметры пришедшие из клиентского js в наши собственные
  # по причине использования чужой библиотеки, не можем изменить клиентские параметры задачи
  def mapping_post_params
    p = params[:tasks_task]
    p[:text] = p.delete(:description.to_s)
    p[:finished_at] = p.delete(:end_date.to_s)
    p[:started_at] = p.delete(:start_date.to_s)
    p
  end

end
