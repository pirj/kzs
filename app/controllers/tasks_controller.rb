class TasksController < ApplicationController
  def execute
    @task = Task.find(params[:id])
    @task.completed = true
    @task.save!
    
    task_list = @task.task_list
    
    if task_list.with_completed_tasks
       task_list.completed = true
       task_list.save!
    end
     
    redirect_to :back, :notice => t('task_completed')
  end
end
