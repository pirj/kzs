class TasksController < ApplicationController
  def execute
    @task = Task.find(params[:id])
    @task.completed = true
    @task.save!
    redirect_to :back, :notice => 'task_completed'
  end
end
