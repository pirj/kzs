class Tasks::ChecklistItemSerializer < ActiveModel::Serializer
  attributes :id,
            :deadline,
            :checked,
            :description,
            :name

  def deadline
    if object.finished_at
      object.finished_at.localtime.strftime("%d-%m-%Y")
    else
      nil
    end
  end
end
