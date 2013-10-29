ActiveAdmin.register Vehicle do
  config.batch_actions = false
  config.clear_sidebar_sections!
  
   index do 
     column :brand
     column :model
     column :register_document
     column :register_sn
     column :vehicle_body
     default_actions
   end

   form do |f|  
     f.inputs t('properties') do
       f.input :brand
       f.input :model
       f.input :register_document
       f.input :register_sn
       f.input :vehicle_body, :as => :select, :collection => Vehicle::WORK_STATUSES.map { |a| [ t(a), a ] }, :include_blank => false
     end
     f.actions
   end

  show do |group|
    attributes_table do
      row :brand
      row :model
      row :register_document
      row :register_sn 
      row :vehicle_body do |row|
        t(row.vehicle_body)
      end
    end 
   end  
end