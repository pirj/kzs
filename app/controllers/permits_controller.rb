class PermitsController < ApplicationController
  def index
    @permits = Permit.all
  end

  def new
    @permit = Permit.new
    authorize! :create, @permit
    @vehicle = @permit.build_vehicle
  end
  
  def create
    @permit = Permit.new(params[:permit])
    last = Permit.last ? Permit.last.id + 1 : 1
    @permit.number = (last).to_s

    respond_to do |format|
      if @permit.save && 
        format.html { redirect_to @permit, notice: t('permit_request_created') }
        format.json { render json: @permit, status: :created, location: @permit }
      else
        format.html { render action: "new" }
        format.json { render json: @permit.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @permit = Permit.find(params[:id])
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
  end
  
  def update
    @permit = Permit.find(params[:id])
    
    respond_to do |format|
      if @permit.update_attributes(params[:permit])
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
  
end
