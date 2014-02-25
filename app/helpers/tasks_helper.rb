# coding: utf-8
module TasksHelper

  def link_to_add_task title, f
    new_object = f.object.send(:tasks).klass.new
    id = new_object.object_id
    fields = f.fields_for(:tasks, new_object, child_index: id) do |builder|
      render(:tasks.to_s.singularize + "_fields", f: builder)
    end
    link_to(title, '#', class: "js-tasks-add-task", data: {id: id, fields: fields.gsub("\n", "")})
  end
  
  #def task_status(task)
  #  if task.completed?
  #    "Выполнена"
  #  else
  #    "Не выполнена"
  #  end
  #end
  #
  #def task_deadline(task)
  #  if task.deadline
  #    task.deadline.strftime('%d.%m.%Y')
  #  else
  #    "Не указан"
  #  end
  #end
  #
  #def task_list(task)
  #  if task.task_list
  #    task.task_list.tasks.completed.count.to_s + " / " + task.task_list.tasks.count.to_s
  #  end
  #end
  #
  #def cause(task)
  #  if task.task_list && task.task_list.document_id
  #    link_to "Распоряжение", document_path(task.task_list.document_id)
  #  elsif task.task_list && task.task_list.statement_id
  #    link_to "Лист замечаний", "#"
  #  else
  #    nil
  #  end
  #end
    
end
