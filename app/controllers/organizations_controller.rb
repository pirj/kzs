class OrganizationsController < ApplicationController
  layout 'base'
  helper_method :sort_column, :sort_direction
  
  def index 
    @organizations = OrganizationsDecorator.decorate( Organization.order(sort_column + " " + sort_direction) )
  end


  def show
    organization = Organization.find(params[:id])
    @users = User.for_organization(organization.id)
    @organization = Organizations::ShowDecorator.decorate(organization)
  end


  def details
    @organization = Organization.find(params[:id])
    respond_to do |format|
      format.pdf { render  :pdf => "file.pdf", :template => 'organizations/details' }
    end
  end


  def new
    @organization = OrganizationDecorator.decorate(Organization.new)
  end


  def edit
    organization = Organization.find(params[:id])
    @users = @users = User.for_organization(organization.id)
    @organization = OrganizationDecorator.decorate(organization)
  end


  def create
    @organization = Organization.new(params[:organization])
    if @organization.save
      redirect_to edit_organization_path(@organization)
    else
      render action: 'new'
    end
  end


  # TODO: need check to user update-permits.
  def update
    @organization = Organization.find(params[:id])
    if @organization.update_attributes(params[:organization])
      redirect_to edit_organization_path(@organization)
    else
      render action: 'edit'
    end
  end


  def destroy
    @organization = Organization.find(params[:id])
    @organization.destroy

    redirect_to organizations_path
  end
  
  
  private
  # TODO: not working code
  def sort_column
    Document.column_names.include?(params[:sort]) ? params[:sort] : 'created_at'
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'desc'
  end
end
