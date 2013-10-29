ActiveAdmin.register User do
  config.batch_actions = false
  filter :username
  
   index do 
     column :id
     column :username
     column :first_name
     column :last_name
     column :phone

     default_actions



   end

   form do |f|  
     f.inputs t('required_fields') do
       f.input :username
       f.input :password
       f.input :password_confirmation
       f.input :first_name
       f.input :middle_name
       f.input :last_name
       f.input :id_type
       f.input :id_sn
       f.input :id_issue_date
       f.input :id_issuer
     end
     
     f.inputs t('properties') do
       f.input :alt_name
       f.input :phone, :as => :string
       f.input :position
       f.input :division
       f.input :dob
       f.input :avatar
       f.input :email
       f.input :organization_id, :as => :select, :collection => Organization.all
       f.input :work_status, :as => :select, :collection => User::WORK_STATUSES.map { |a| [ t(a), a ] }, :include_blank => false
       f.input :groups, :as => :check_boxes
     end
     f.actions
   end

  show do |user|
    attributes_table do
      row :username
      row :organization_id do |row|
        Organization.find(user.organization_id).title
      end
      row :phone
      row :position
      row :division
      row :dob
      row :first_name
      row :last_name
      row :avatar
      row :current_sign_in_ip
      row :last_sign_in_at
      row :sign_in_count
      row :email
      row :organization_id
      row :work_status do |row|
        I18n.t(row.work_status)
      end
      row :created_at
    end
      
     panel t('permissions') do 
       table_for user.permissions do 
         column :title
         column :description
       end
     end
     
     panel t('groups') do 
       table_for user.groups do 
         column :title
       end
     end
      
   end
   
   controller do
     
     def create
       @user = User.new(params[:user])
 
       group_ids = params[:user][:group_ids]
       permission_ids = Permission.includes(:groups).where("groups.id" => group_ids)      
       
       respond_to do |format|
         if @user.save && @user.permissions << permission_ids
           format.html { redirect_to admin_user_path(@user), notice: t('user_successfully_created') }
         else
           format.html { render action: "new" }
           format.json { render json: @user.errors, status: :unprocessable_entity }
         end
       end
     end
     
     
     def update
       @user = User.find(params[:id])
       
       @user.groups.clear
       @user.permissions.clear
        
       group_ids = params[:user][:group_ids]
       permission_ids = Permission.includes(:groups).where("groups.id" => group_ids)
        
           
        if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
            params[:user].delete(:password)
            params[:user].delete(:password_confirmation)
        end
       
       respond_to do |format|
         if @user.update_attributes(params[:user]) && @user.permissions << permission_ids
           format.html { redirect_to admin_user_path(@user), notice: t('user_successfully_updated') }
           format.json { head :no_content }
         else
           format.html { render action: "edit" }
           format.json { render json: @user.errors, status: :unprocessable_entity }
         end
       end
     end
      
   end
   
end
