ActiveAdmin.register User do
  config.batch_actions = false
  filter :username
  #TODO это мешает загрузить окружение, поэтому новый член команды не сможет накатить миграции или запустить консоль
  # в rails3 .all возвращает массив, делая запрос к БД, если я не путаю то в 4-х будет уже relation
  # поэтому можно сделать  Organization.scoped
  filter :organization_id, :as => :check_boxes, :collection => Organization.all, :include_blank => false
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
       f.input :password
       f.input :password_confirmation
       f.input :first_name
       f.input :middle_name
       f.input :last_name
       f.input :id_type, :as => :select, :collection => UserDocumentType.all, :include_blank => false
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
       if current_user.sys_user
         f.input :organization_id, :as => :select, :collection => Organization.all
       else
         f.input :organization_id, :as => :hidden, :value => current_user.organization_id
       end
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
