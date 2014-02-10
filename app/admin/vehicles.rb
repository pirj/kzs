ActiveAdmin.register Vehicle do
  config.batch_actions = false
  config.clear_sidebar_sections!
  
   index do 
     column :id
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
       f.input :first_letter
       f.input :sn_number
       f.input :second_letter
       f.input :third_letter
       f.input :sn_region, :as => :string
       f.input :vehicle_body, :as => :select, :collection => Vehicle::VEHICLE_BODY.map { |a| [ t(a), a ] }, :include_blank => false
       f.input :users, :as => :check_boxes
     end
     f.actions
   end

  show do |vehicle|
    attributes_table do
      row :brand
      row :model
      row :register_document
      row :register_sn 
      row :sn_region
      row :vehicle_body do |row|
        t(row.vehicle_body)
      end
    end 
    panel t('drivers') do 
      table_for vehicle.users do 
        column :first_name do |column|
          column.first_name_with_last_name
        end
      end
    end
   end  
end