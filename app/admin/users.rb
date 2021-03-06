ActiveAdmin.register User do
  config.batch_actions = false
  filter :username
  filter :organization_id, :as => :check_boxes, :collection => Organization.scoped, :include_blank => false
  menu :priority => 1

   index do
     column :id
     column :username
     column :first_name
     column :last_name
     column :organization_id do |user|
       if user.organization_id
         Organization.find(user.organization_id).title
       end
     end

     default_actions



   end

   form do |f|
     f.inputs t('required_fields') do
       f.input :username
       if current_user.sys_user
         f.input :organization_id, :as => :select, :collection => Organization.scoped
       else
         f.input :organization_id, :as => :hidden, :value => current_user.organization_id
       end
       f.input :position
       f.input :first_name
       f.input :middle_name
       f.input :last_name      
       f.input :password
       f.input :password_confirmation
     end

     f.inputs t('properties') do
       # TODO nullified collection with UserDocumentType
       f.input :id_type, :as => :select, :collection => [], :include_blank => false
       f.input :id_sn
       f.input :id_issue_date
       f.input :id_issuer
       f.input :alt_name
       f.input :phone, :as => :string
       f.input :division
       f.input :dob
       f.input :avatar
       f.input :email
       f.input :work_status, :as => :select, :collection => User::WORK_STATUSES.map { |a| [ t(a), a ] }, :include_blank => false
       f.input :groups, :as => :check_boxes
     end
     f.actions
   end

  show do |user|
    attributes_table do
      row :username
      row :organization_id do |row|
        if Organization.exists?(user.organization_id)
          Organization.find(user.organization_id).title
        end
      end
      row :position
      row :first_name
      row :middle_name
      row :last_name
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

       if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
           params[:user].delete(:password)
           params[:user].delete(:password_confirmation)
       end


       group_ids = params[:user][:group_ids]
       permission_ids = Permission.includes(:groups).where("groups.id" => group_ids)

       @user.groups.clear
       @user.permissions.clear
       @user.permissions << permission_ids


       respond_to do |format|
         if @user.update_attributes(params[:user])

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
