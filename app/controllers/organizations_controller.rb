class OrganizationsController < ApplicationController
  layout 'organizations'
  helper_method :sort_column, :sort_direction
  
  def index 
    @organizations = Organization.order(sort_column + " " + sort_direction)

    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def show
    @organization = Organization.find(params[:id])
    @users = User.where(:organization_id => current_user.organization_id)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @organization }
    end
  end

  # GET /organizations/new
  # GET /organizations/new.json
  def new
    @organization = Organization.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @organization }
    end
  end
  
  def edit
    
    @organization = Organization.find(params[:id])
    @users = User.where(:organization_id => current_user.organization_id)
    
    if current_user.organization_id != @organization.id
      redirect_to :back, :alert => t('access_denied')
    end

  end

  # POST /organizations
  # POST /organizations.json
  def create
    @organization = Organization.new(params[:organization])

    respond_to do |format|
      if @organization.save
        format.html { redirect_to edit_organization_path(@organization), notice: 'Organization was successfully created.' }
        format.json { render json: @organization, status: :created, location: @organization }
      else
        format.html { render action: "new" }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /organizations/1
  # PUT /organizations/1.json
  def update
    @organization = Organization.find(params[:id])

    respond_to do |format|
      if @organization.update_attributes(params[:organization])
        format.html { redirect_to edit_organization_path(@organization), notice: 'Organization was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /organizations/1
  # DELETE /organizations/1.json
  def destroy
    @organization = Organization.find(params[:id])
    @organization.destroy

    respond_to do |format|
      format.html { redirect_to organizations_url }
      format.json { head :no_content }
    end
  end
  
  
  private
  
  def sort_column
    Document.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end
end
