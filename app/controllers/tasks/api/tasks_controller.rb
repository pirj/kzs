class Tasks::Api::TasksController < ResourceController
  layout false
  respond_to :json

  # by default you get parent tasks only.
  # It you want to search - just add parent_only: false to params
  has_scope :parents_only, type: :boolean, default: true

  def index
    @search = search_scope.ransack(params[:q])
    @tasks = @search.result(distinct: true).includes(:inspector, :executor, :checklists=>:checklist_items)
    render json: collection, root: 'data', each_serializer: Tasks::TaskSerializer    
  end

  # GET /api/tasks/:id/subtasks
  # url helper subtasks_api_task(:id)

  def subtasks
    @task = Tasks::Task.find(params[:id])
    @tasks = @task.subtasks
    render json: @tasks, root: false, each_serializer: Tasks::TaskSerializer
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
      success = false
      if params[:id] && params[:action] && resource.current_state.events.keys.include?(params[:action].to_sym)
        success = resource.send("#{params[:action]}!")
      end

      resource.notify_interesants(exclude: current_user) if success

      [resource.inspector, resource.executor].uniq.reject{|u| u == current_user}.each do |user|
        NotificationMailer.task_state_changed(user, resource).deliver!
      end

      respond_to do |format|
        format.json { render json: {current_state: resource.current_state.to_s} }
        format.js { render "task_state_update" }
      end
    end
  end

  private

  def search_scope
    apply_scopes(scope)
  end

  def scope
    Tasks::Task.for_organization(current_organization)
  end
end