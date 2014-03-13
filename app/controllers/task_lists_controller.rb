# TODO: important! this would not work too
class TaskListsController < ApplicationController
  def create
    @task_list = TaskList.new(params[:task_list])
    @statement = Statement.find(params[:task_list][:statement_id])
    @task_list.statement_id = @statement.id
    @statement.not_accepted = true
    @statement.save
    document = Document.find(@statement.document_id)
    document.with_comments = true
    document.save

    if @task_list.save
      assign_organizations_to_tasks(@statement)
      redirect_to statement_path(@statement),
                  notice: t("task_list_successfully_created")
    else
      render action: "new"
    end
  end

  def update
    @task_list = TaskList.find(params[:id])
    @task_list.update_attributes(params[:task_list])
    #@id = params[:task_list]

    respond_to do |format|
      format.js { render layout: false }
    end
  end

  private

  def assign_organizations_to_tasks(document)
    document.task_list.tasks.each do |task|
      task.deadline = document.task_list.deadline
      task.executor_organization_id = document.sender_organization_id
      task.sender_organization_id = document.organization_id
      task.save!
    end
  end
end
