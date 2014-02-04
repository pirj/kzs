ActiveAdmin.register Organization do


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
         f.input :director_id, :as => :select, :collection => User.scoped.map { |u| [ u.first_name_with_last_name, u.id ] }
       end

       f.inputs t('main_info') do
         f.input :admin_id, :as => :select, :collection => User.scoped
         f.input :parent_id, :as => :select, :collection => Organization.scoped
         f.input :logo, :as => :file
         f.input :phone
         f.input :mail
         f.input :date_of_registration
         f.input :tax_authority_that_registered
         f.input :certificate_of_tax_registration, :as => :file
         f.input :creation_resolution_date
         f.input :creation_resolution, :as => :file
         f.input :articles_of_organization, :as => :file
         f.input :accountant_id, :as => :select, :collection => User.scoped.map { |u| [ u.first_name_with_last_name, u.id ] }
         f.input :inn
         f.input :kpp
         f.input :bik
         f.input :egrul_registration_date
         f.input :egrul_excerpt, :as => :file
       end



       f.inputs t('account_details') do
         f.input :bank_title
         f.input :bank_address
         f.input :bank_correspondent_account
         f.input :bank_bik
         f.input :bank_inn
         f.input :bank_kpp
         f.input :bank_okved
         f.input :organization_account
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
