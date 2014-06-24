class Tasks::ChecklistItemSerializer < ActiveModel::Serializer
  attributes :id,
            :deadline,
            :checked,
            :description,
            :name,
            :task_id


  def task_id
    object.checklist.task.id
  end

  def deadline
    if object.finished_at
      object.finished_at.localtime.strftime("%d-%m-%Y")
    else
      nil
    end
  end
  
  def checked
    object.checked ? 'true' : 'false'
  end
end
