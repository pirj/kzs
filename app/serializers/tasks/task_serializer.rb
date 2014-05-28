class Tasks::TaskSerializer < ActiveModel::Serializer
  attributes :id,
            :title,
            :started_at,
            :finished_at,
            :parent_id,
            :state,
            :description,
            :start_date,
            :duration,
            :parent_id

  def description
    object.text
  end

  def start_date
    started_at
  end

  def started_at
    @started_at = object.started_at
    @started_at ? @started_at.localtime.strftime("%d-%m-%Y") : nil
  end

  def finished_at
    @started_at = object.started_at
    @started_at ? @started_at.localtime.strftime("%d-%m-%Y") : nil
  end

  def duration
    (object.finished_at.to_i - object.started_at.to_i)/1.day
  end

  def state
    object.current_state.to_s
  end

  has_one :executor, serializer: NameOnlyUserSerializer
  has_one :inspector, serializer: NameOnlyUserSerializer

  has_many :checklists, serializer: Tasks::ChecklistSerializer
end
