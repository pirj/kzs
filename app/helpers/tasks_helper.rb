# coding: utf-8

module TasksHelper
  
  def task_status(task)
    if task.completed
      "Выполнена"
    else
      "Не выполнена"
    end
  end
  
  def task_deadline(task)
    if task.deadline
      task.deadline.strftime('%d.%m.%Y')
    else
      "Не указан"
    end
  end
end
