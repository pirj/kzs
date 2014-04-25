# This serves to update Task status from /orders/show/html.slim
#
# TODO: by @serj_prikhodko
# It should be validated that the user have permissions to mark task done
#
#
class TaskListsController < ApplicationController
  def update
    @task_list = TaskList.find(params[:id])
    @task_list.update_attributes(params[:task_list])

    respond_to do |format|
      format.js { render layout: false }
    end
  end
end
