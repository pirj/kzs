# coding: utf-8

module TaskListsHelper
  
  def task_status(task)
    if task.completed?
      "Выполнено"
    else
      "Не выполнено"
    end
  end
  
end
