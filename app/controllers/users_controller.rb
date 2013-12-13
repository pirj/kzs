class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])
    
    
    respond_to do |format|
      if @user.save
        format.html { redirect_to users_path, notice: t("user_successfully_created") }
      else
        format.html { render action: "new" }
      end
    end

  end

  def update
    @user = User.find(params[:id])
      if @user.update_attributes(params[:user])
        flash[:notice] = t("user_successfully_updated")
        sign_in(@user, :bypass => true)
        redirect_to users_path
      else
        render :action => 'edit'
      end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

end
