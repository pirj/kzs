class PermitsController < ApplicationController
  layout 'base'
  helper_method :sort_column, :sort_direction

  before_filter :organizations, only: [:create, :edit, :user, :vehicle, :daily]       # TODO: @vit need refactor
  before_filter :permit_types, only: [:create, :edit, :user, :vehicle, :daily]
  before_filter :car_brand_types, only: [:create, :edit, :user, :vehicle, :daily]
  before_filter :car_brands, only: [:create, :edit, :user, :vehicle, :daily]
  before_filter :number_letters, only: [:create, :edit, :vehicle, :daily]
  before_filter :daily_document_type, only: [:create, :edit, :daily]
  before_filter :num_regions, only: [:create, :edit, :vehicle, :daily]

  # TODO "authorize! :create, @permit" прописан не для всех action

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
    elsif params[:scope] == "vehicles"
      @permits = @permits.vehicles
    elsif params[:scope] == "walkers"
      @permits = @permits.walkers
    elsif params[:scope] == "for_print"
      @permits = @permits.for_print.walkers
    else
      @permits = @permits.where { (agreed == true) || (rejected == true) }
    end
  end

  def user
    @permit = Permit.new
    authorize! :create, @permit
    @vehicle = @permit.build_vehicle
    @user = @permit.build_user
    @daily_pass = @permit.build_daily_pass
    @drivers = User.with_permit
    @users = User.all
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
    last = Permit.last ? Permit.last.id + 1 : 1 # TODO баг, нет гарантии что в базе уже не появился документ с таким же номером
    @permit.number = (last).to_s
    @permit.organization_id = current_user.organization_id

    if @permit.save
      if @permit.vehicle
        vehicle = @permit.vehicle

        if @permit.way_bill
          vehicle.user_ids = nil # FIX вместо валидации "validates :user_ids" в модели Vehicle
        else
          # TODO нет проверки, можно залить левые ids
          # drivers = params[:permit][:drivers].flatten.compact
          # vehicle.user_ids = User.find(drivers).map(&:id)
          drivers = params[:permit][:drivers]
          vehicle.user_ids = drivers
          vehicle.save!
        end
      end

      redirect_to @permit, notice: t('permit_request_created')
    else
      case @permit.permit_type
      when 'user'
        render action: 'user'
      when 'vehicle'
        @drivers = User.with_permit
        render action: 'vehicle'
      when 'daily'
        render action: 'daily'
      end
    end
  end

  def show
    @permit = Permit.find(params[:id])
    @user = @permit.user
    @daily_pass = @permit.daily_pass
    respond_to do |format|
      format.html
      format.js { @permit = @permit }
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
      redirect_to :back, alert: t('access_denied')
    end

    @users = User.all
  end

  def update
    @permit = Permit.find(params[:id])

    if @permit.permit_type == 'vehicle'
      drivers = params[:permit][:drivers]
      drivers = drivers.delete_if { |x| x.empty? }
    end

    if @permit.update_attributes(params[:permit])
      if @permit.permit_type == 'vehicle'
        vehicle = @permit.vehicle
        vehicle.user_ids = drivers
        vehicle.save!
      end

      redirect_to permit_path(@permit),
                  notice: t('permit_successfully_updated')
    else
      organizations
      render action: "edit"
    end
  end

  def agree
    @permit = Permit.find(params[:id])
    @permit.agreed = true
    @permit.rejected = false
    @permit.save

    redirect_to permit_path(@permit), notice: t('permit_agreed')
  end

  def reject
    @permit = Permit.find(params[:id])
    @permit.agreed = false
    @permit.rejected = true
    @permit.save

    redirect_to permit_path(@permit), notice: t('permit_rejected')
  end

  def cancel
    @permit = Permit.find(params[:id])
    @permit.canceled = true
    @permit.save

    redirect_to permit_path(@permit), notice: t('permit_canceled')
  end

  def release
    @permit = Permit.find(params[:id])
    @permit.released = true

    if @permit.permit_type == 'daily'
      @permit.daily_pass.guard_duty_id = current_user.id
    end

    @permit.save

    redirect_to permit_path(@permit), notice: t('permit_released')
  end

  def issue
    @permit = Permit.find(params[:id])
    @permit.issued = true
    @permit.save

    redirect_to permit_path(@permit), notice: t('permit_issued')
  end

  def group_print
    @permits = Permit.where(id: params[:permit_ids])

    pdf = PermitGroupPrintPdf.new(@permits, view_context)
    # TODO: move pdf generation in backgroung (delayed_job for ex)
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

  def permit_types            # TODO: @vit need check
    @permit_types ||= Permit::PERMIT_CLASSES.map { |a| [t(a), a] }
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

  def daily_document_type
    @daily_document_type ||= DailyPass::DOCUMENT_TYPES.map { |t| [t, t] }
  end

  def num_regions
    @regions = CarRegion.numbers
  end
end
