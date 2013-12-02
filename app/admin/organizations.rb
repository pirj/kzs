ActiveAdmin.register Organization do
    config.batch_actions = false
    filter :username
    config.sort_order = "id_asc"
    menu :priority => 1

     index do 
       column :id
       column :title
       column :parent_id do |column|
         if Organization.exists?(column.parent_id)
           Organization.find(column.parent_id).title
         end
       end
       default_actions
     end

     form do |f|  
       f.inputs t('required_fields') do
         f.input :title
         f.input :short_title
         f.input :type_of_ownership
         f.input :legal_address
         f.input :actual_address
         f.input :director_id, :as => :select, :collection => User.all.map { |u| [ u.first_name_with_last_name, u.id ] }
      
       end
       f.inputs t('properties') do
         f.input :inn
         f.input :admin_id, :as => :select, :collection => User.all
         f.input :parent_id, :as => :select, :collection => Organization.all
         f.input :logo, :as => :file
         f.input :phone
         f.input :mail
       end
       f.actions
     end

    show do
      attributes_table do
        row :title
        row :short_title
        row :type_of_ownership
        row :legal_address
        row :actual_address
        row :director_id
        
        row :inn
        row :admin_id
        row :parent_id
        row :logo do |row|
          image_tag row.logo.url(:pdf)
        end
        row :phone
        row :mail
      end  
     end
end
