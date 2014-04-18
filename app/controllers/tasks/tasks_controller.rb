class Tasks::TasksController < InheritedResources::Base
  layout 'base'

  def index
    @tasks = Tasks::Task.order('created_at DESC')
  end
end
