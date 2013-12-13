class Organization < ActiveRecord::Base
  attr_accessible :title, :parent_id, :lft, :rgt, :logo,
                  :phone, :mail, :director_id, :short_title, :inn, :admin_id,
                  :type_of_ownership, :legal_address, :actual_address, 
                  :date_of_registration, :tax_authority_that_registered, :certificate_of_tax_registration,
                  :creation_resolution_date, :creation_resolution, :articles_of_organization, 
                  :accountant_id, :kpp, :ogrn, :bik, :ogrn, :bik, :egrul_registration_date, 
                  :egrul_excerpt, :bank_title, :bank_address, :bank_correspondent_account,
                  :bank_bik, :bank_inn, :bank_kpp, :bank_okved, :organization_account
                  
                  
                  
                  
                  
  acts_as_nested_set
  
  # validates :short_title, :inn, :admin_id, :presence => true
  has_attached_file :logo, :styles => { :pdf => "120x70#" } 
  
  has_attached_file :certificate_of_tax_registration
  has_attached_file :creation_resolution
  has_attached_file :articles_of_organization
  has_attached_file :egrul_excerpt
  
  has_many :users
  
  def users_statement
    self.users.statement_approvers
  end
end