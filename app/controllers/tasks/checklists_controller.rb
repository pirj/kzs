class Tasks::ChecklistsController < ResourceController
  layout 'base'

  respond_to :js, :html

  def create
    resource.updated_by = current_user.id
    super
  end

  def update
    resource.updated_by = current_user.id

    super do |format|
      format.js {render nothing: true}
    end
  end

end
