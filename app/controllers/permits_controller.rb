class PermitsController < ApplicationController
  layout 'base'
  helper_method :sort_column, :sort_direction
  before_filter :organizations, only: [:edit, :user, :vehicle, :daily]       #TODO: @vit need refactor
  before_filter :permit_types, only: [:edit, :user, :vehicle, :daily]
  before_filter :car_brand_types, only: [:edit, :user, :vehicle, :daily]
  before_filter :car_brands, only: [:edit, :user, :vehicle, :daily]
  before_filter :number_letters, only: [:edit, :vehicle, :daily]


  def index
    
    if params[:status_sort]
      direction = params[:direction]
      sort_type = "canceled #{direction}", "rejected #{direction}", "issued #{direction}", "released #{direction}", "agreed #{direction}"
    else
      sort_type = sort_column + " " + sort_direction
    end
    
    @permits = Permit.order(sort_type)
    
    @controller = params[:controller]
    
    
    if params[:scope] == "expired"
      @permits = @permits.expired
    elsif params[:scope] == "application"
      @permits = @permits.applications
    elsif params[:scope] == "daily"
      @permits = @permits.daily
    elsif params[:scope] == "for_print"
      @permits = @permits.for_print.walkers
    else
      @permits = @permits.where{(agreed == true) || (rejected == true)}
    end
    
    
  end

  def user
    @permit = Permit.new
    authorize! :create, @permit
    @vehicle = @permit.build_vehicle
    @user = @permit.build_user
    @daily_pass = @permit.build_daily_pass
    @drivers = User.with_permit
  end

  def vehicle
    @permit = Permit.new
    authorize! :create, @permit
    @vehicle = @permit.build_vehicle
    @user = @permit.build_user
    @daily_pass = @permit.build_daily_pass
    @drivers = User.with_permit
  end

  def daily
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
    @permit.organization_id = current_user.organization_id
    if params[:permit][:date] && params[:permit][:date] != ''
      @permit.start_date = Date.parse(params[:permit][:date])
      @permit.expiration_date = Date.parse(params[:permit][:date])
    end
    
    
    drivers = params[:permit][:drivers]
    #drivers = drivers.delete_if{ |x| x.empty? }
    @permit.save!
    if @permit.vehicle
      vehicle = @permit.vehicle
      vehicle.user_ids = drivers
      vehicle.save!
    end
    
    redirect_to @permit, notice: t('permit_request_created')
  end

  def show
    @permit = Permit.find(params[:id])
    @user = @permit.user
    @daily_pass = @permit.daily_pass
    respond_to do |format|
      format.html
      format.js {@permit = @permit}
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
    
    if current_user.has_permission?(10) || @permit.organization_id == current_user.organization_id
      
      @drivers = User.with_permit
    else
      redirect_to :back, :alert => t('access_denied')
    end

  end
  
  def update
    @permit = Permit.find(params[:id])

    if @permit.permit_type == 'vehicle'
      drivers = params[:permit][:drivers]
      drivers = drivers.delete_if{ |x| x.empty? }
    end
    

    
    

      if @permit.update_attributes(params[:permit])
        if @permit.permit_type == 'vehicle'
          vehicle = @permit.vehicle
          vehicle.user_ids = drivers
          vehicle.save!
        end

        redirect_to permit_path(@permit), notice: t('permit_successfully_updated')
      else
        render action: "edit"
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

  def organizations
    @organizations = Organization.all
  end

  def permit_types            #TODO: @vit need check
    @permit_types ||= Permit::PERMIT_CLASSES.map{ |a| [ t(a), a ] }
  end

  def car_brand_types
    @car_brand_types ||= CarBrandType.all
  end

  def car_brands
    @car_brands = CarBrand.all
  end

  def number_letters
    @number_letters =  Vehicle::LETTERS
  end



end
