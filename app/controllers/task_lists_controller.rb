class TaskListsController < ApplicationController
  def create
    @task_list = TaskList.new(params[:task_list])
    @statement = Statement.find(params[:task_list][:statement_id])
    @task_list.statement_id = @statement.id
    @statement.not_accepted = true
    @statement.save
    @writ = Document.find(@statement.document_id)
    @writ.with_comments = true
    @writ.save
    
    assign_organizations_to_tasks(@writ)
    
    respond_to do |format|
      if @task_list.save
        format.html { redirect_to statement_path(@statement), notice: t("user_successfully_created") }
      else
        format.html { render action: "new" }
      end
    end

  end
  
  
  private
    
  def assign_organizations_to_tasks(document)
    document.task_list.tasks.each do |task|
      task.executor_organization_id = document.organization_id
      task.sender_organization_id = document.sender_organization_id
      task.save!
    end
  end
  
end
