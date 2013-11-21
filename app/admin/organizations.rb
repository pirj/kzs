ActiveAdmin.register Organization do
    config.batch_actions = false
    filter :username
    config.sort_order = "id_asc"

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
         f.input :short_title
         f.input :inn
         f.input :admin_id, :as => :select, :collection => User.all
       end
       f.inputs t('properties') do
         f.input :title
         f.input :parent_id, :as => :select, :collection => Organization.all
         f.input :logo, :as => :file
         f.input :address
         f.input :phone
         f.input :mail
         f.input :director_id, :as => :select, :collection => User.all
       end
       f.actions
     end

    show do
      attributes_table do
        row :short_title
        row :inn
        row :admin_id
        row :title
        row :parent_id
        row :logo do |row|
          image_tag row.logo.url(:pdf)
        end
        row :address
        row :phone
        row :mail
        row :director_id
      end  
     end
end
