class TasksController < ApplicationController
  
  helper_method :sort_column, :sort_direction
  
  def index 
    @tasks = Task.order(sort_column + " " + sort_direction)
    if params[:scope] == "expired"
      @tasks = @tasks.expired
    else
      @tasks = @tasks
    end
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def execute
    @task = Task.find(params[:id])
    
    if current_user.organization_id == @task.executor_organization_id    
      @task.completed = true
      @task.save!  
      task_list = @task.task_list
      if task_list.with_completed_tasks
         task_list.completed = true
         task_list.save!
      end
      redirect_to :back, :notice => t('task_completed')
    else
      redirect_to :back, :notice => t('permission_denied')
    end
  end
  
  def show
    @task = Task.find(params[:id])
  end
  
  
  
  private
  
  def sort_column
    Document.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end
  
  
end
