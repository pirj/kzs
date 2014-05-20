class Tasks::ChecklistsController < ResourceController
  layout 'base'


  respond_to :js, :html

  def update
    super do |format|
      format.js {render nothing: true}
    end

  end

end
