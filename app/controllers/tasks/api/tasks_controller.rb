class Tasks::Api::TasksController < ResourceController
  layout nil

  has_scope :for_organization, only: [:index]

  respond_to :json

  def index
    super do |success|
      success.json { render json: collection_as_json }
    end
  end

  private

  def collection_as_json
    {
        :data => collection.map do |task|
                  {
                      id: task.id,
                      text: task.title,
                      start_date: task.started_at.strftime("%d-%m-%Y"),
                      duration: days_duration_for(task)
                  }
                end
    }
  end

  def days_duration_for(task)
    (task.finished_at - task.started_at).to_i/1.day
  end


end
