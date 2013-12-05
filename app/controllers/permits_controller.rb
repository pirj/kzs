class PermitsController < ApplicationController
  helper_method :sort_column, :sort_direction
  
  def index
    
    if params[:status_sort]
      direction = params[:direction]
      sort_type = "canceled #{direction}", "rejected #{direction}", "issued #{direction}", "released #{direction}", "agreed #{direction}"
    else
      sort_type = sort_column + " " + sort_direction
    end
    
    @permits = Permit.order(sort_type)
    
    
    
    if params[:scope] == "expired"
      @permits = @permits.expired
    elsif params[:scope] == "application"
      @permits = @permits.applications
    elsif params[:scope] == "for_print"
      @permits = @permits.for_print.walkers
    else
      @permits = @permits
    end
    
    
  end

  def new
    @permit = Permit.new
    authorize! :create, @permit
    @vehicle = @permit.build_vehicle
    @user = @permit.build_user
    @daily_pass = @permit.build_daily_pass
    @drivers = User.with_permit
  end
  
  def create
    @permit = Permit.new(params[:permit])
    last = Permit.last ? Permit.last.id + 1 : 1
    @permit.number = (last).to_s
    if params[:permit][:date] && params[:permit][:date] != ''
      @permit.start_date = Date.parse(params[:permit][:date])
      @permit.expiration_date = Date.parse(params[:permit][:date])
    end
    
    
    drivers = params[:permit][:drivers]
    drivers = drivers.delete_if{ |x| x.empty? }
    @permit.save!
    
    vehicle = @permit.vehicle
    vehicle.user_ids = drivers
    vehicle.save!
    
    redirect_to @permit, notice: t('permit_request_created')
  end

  def show
    @permit = Permit.find(params[:id])
    @user = @permit.user
    @daily_pass = @permit.daily_pass
    respond_to do |format|
      format.html
      format.pdf do
        pdf = PermitPdf.new(@permit, view_context)
        send_data pdf.render, filename: "permit#{@permit.id}.pdf",
                              type: "application/pdf",
                              disposition: "inline"
      end
    end
  end
  
  def edit
    @permit = Permit.find(params[:id])
    @drivers = User.with_permit
  end
  
  def update
    @permit = Permit.find(params[:id])
    
    drivers = params[:permit][:drivers]
    drivers = drivers.delete_if{ |x| x.empty? }
    

    
    
    respond_to do |format|
      if @permit.update_attributes(params[:permit])
        vehicle = @permit.vehicle
        vehicle.user_ids = drivers
        vehicle.save!
        format.html { redirect_to permit_path(@permit), notice: t('permit_successfully_updated') }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @permit.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def agree
    @permit = Permit.find(params[:id])
    @permit.agreed = true
    @permit.rejected = false
    @permit.save    

    respond_to do |format|
      format.html { redirect_to permit_path(@permit), notice: t('permit_agreed') }
      format.json 
    end
  end
  
  def reject
    @permit = Permit.find(params[:id])
    @permit.agreed = false
    @permit.rejected = true
    @permit.save    

    respond_to do |format|
      format.html { redirect_to permit_path(@permit), notice: t('permit_rejected') }
      format.json 
    end
  end
  
  def cancel
    @permit = Permit.find(params[:id])
    @permit.canceled = true
    @permit.save    

    respond_to do |format|
      format.html { redirect_to permit_path(@permit), notice: t('permit_canceled') }
      format.json 
    end
  end
  
  def release
    @permit = Permit.find(params[:id])
    @permit.released = true
    @permit.save    

    respond_to do |format|
      format.html { redirect_to permit_path(@permit), notice: t('permit_released') } 
      format.json 
    end
  end
  
  def issue
    @permit = Permit.find(params[:id])
    @permit.issued = true
    @permit.save    

    respond_to do |format|
      format.html { redirect_to permit_path(@permit), notice: t('permit_issued') } 
      format.json 
    end
  end
  
  def group_print
    @permits = Permit.where(:id => params[:permit_ids])
    
    pdf = PermitGroupPrintPdf.new(@permits, view_context)
    send_data pdf.render, filename: "permits.pdf",
                          type: "application/pdf",
                          disposition: "inline"
  end
  
  private
  
  def sort_column
    Permit.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end
  
end
