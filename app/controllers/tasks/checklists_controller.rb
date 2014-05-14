class Tasks::ChecklistsController < ResourceController
  layout 'base'


  respond_to :js, :html

  def update
    render nothing: true
  end

end
