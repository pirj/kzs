class Tasks::ChecklistSerializer < ActiveModel::Serializer
  attributes :id,
            :name,
            :created_at

  has_many :checklist_items, serializer: Tasks::ChecklistItemSerializer
end
