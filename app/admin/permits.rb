ActiveAdmin.register Permit do
  config.batch_actions = false
  config.clear_sidebar_sections!
  
   index do 
     column :id
     column :number
     column :permit_type
     column :user_id
     column :vehicle_id
     column :permit_class
     column :start_date
     column :expiration_date
     default_actions
   end

   form do |f|  
     f.inputs t('required_fields') do
       f.input :number, :as => :string
       f.input :permit_type, :as => :select, :collection => Permit::TYPES.map { |a| [ t(a), a ] }, :include_blank => false
       f.input :permit_class, :as => :select, :collection => Permit::PERMIT_CLASSES.map { |a| [ t(a), a ] }, :include_blank => false
       f.input :user_id, :as => :select, :collection => User.all
       f.input :vehicle_id, :as => :select, :collection => Vehicle.all.map{|v| ["#{v.register_sn} #{v.brand} #{v.model}", v.id]}
       f.input :start_date
       f.input :expiration_date
     end
     f.actions
   end

  show do |group|
    attributes_table do
      row :id
      row :number
      row :permit_type
      row :user_id
      row :vehicle_id
      row :permit_class
      row :start_date
      row :expiration_date
    end  
  
   end
end