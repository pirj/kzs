# coding: utf-8

module TasksHelper
  
  def task_status(task)
    if task.completed?
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
  
  def task_list(task)
    if task.task_list
      task.task_list.tasks.completed.count.to_s + " / " + task.task_list.tasks.count.to_s
    end
  end
  
  def cause(task)
    if task.task_list && task.task_list.document_id 
      link_to "Распоряжение", document_path(task.task_list.document_id)
    elsif task.task_list && task.task_list.statement_id 
      link_to "Лист замечаний", "#"
    else
      nil
    end
  end
    
end
