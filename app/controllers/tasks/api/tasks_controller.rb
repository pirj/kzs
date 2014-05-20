class Tasks::Api::TasksController < ResourceController
  layout false

  before_filter :permit_params, only: [:create, :update]
  has_scope :for_organization, only: [:index]
  respond_to :json

  def index
    @search = collection.ransack(params[:q])
    super do |success|
      success.json { render json: collection_as_json(@search.result(distinct:true)) }
    end
  end

  def create
    @task = Tasks::Task.new(params[:tasks_task]).tap do |task|
      task.organization = current_user.organization
      # заглушка на первое время,чтобы не выключать валидации в модели
      task.inspectors << User.where(organization_id: current_user.organization.id).first
      task.executors << User.where(organization_id: current_user.organization.id).last
    end
    super
  end
  

  def update
    @task = Tasks::Task.find(params[:id])
    @task.organization ||= current_user.organization
    @task.inspectors << User.where(organization_id: current_user.organization.id).first  if @task.inspectors.blank?
    @task.executors << User.where(organization_id: current_user.organization.id).last   if @task.executors.blank?
    super
  end

  # api методы для передвижения задачи по статусам
  #
  # формат запроса:
  # post { id: task_id, action: next_state }
  #
  # формат ответа:
  # json или js
  #
  # передвижение по статусам для всех экшенов одинаковое на данном этапе реализации методов
  #
  # самое простое обращение к этим методам через ссылку во вьюхе:
  # link_to 'action_name', action_api_tasks_path(task_id), remote: true, method: :post
  %w(cancel start pause resume reformulate finish).each do |method_name|
    define_method method_name do
      @is_transition = false
      if params[:id] && params[:action] && resource.current_state.events.keys.include?(params[:action].to_sym)
        @is_transition = resource.send("#{params[:action]}!")
      end

      respond_to do |format|
        format.json { render json: {is_transition: @is_transition, current_state: resource.current_state.to_s} }
        format.js { render "task_state_update" }
      end
    end
  end


  private

  def collection_as_json(data)
    {
        :data => data.map do |task|
                  {
                      id: task.id,
                      title: task.title,
                      description: task.text,
                      start_date: task.started_at.localtime.strftime("%d-%m-%Y"),
                      state: task.current_state.to_s,
                      duration: days_duration_for(task),
                      checklist: task.checklists,
                      checklist_items: task.checklists.map do |check_list|
                         check_list.checklist_items.map do |item|
                          {
                            checked: item.checked,
                            id: item.id,
                            checklist_id: item.checklist_id,
                            finished_at: item.finished_at.try(:localtime).try(:strftime, "%d-%m-%Y"),
                            description: item.description,
                            name: item.name
                          }
                         end
                      end
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
