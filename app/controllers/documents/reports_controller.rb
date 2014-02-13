class Documents::ReportsController < ResourceController
  include Documents::Base

  layout 'base'
  actions :all, except: [:index]

  def copy
    @parent_report = end_of_association_chain.find(params[:id])

    @report = end_of_association_chain.new
    @report.document = @parent_report.document.safe_clone

    render action: :new
  end

  def show
    show!{
      @report = Documents::ShowDecorator.decorate(resource)
    }
  end
end