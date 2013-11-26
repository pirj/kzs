class Organization < ActiveRecord::Base
  attr_accessible :title, :parent_id, :lft, :rgt, :logo,
                  :phone, :mail, :director_id, :short_title, :inn, :admin_id,
                  :type_of_ownership, :legal_address, :actual_address
                  
  acts_as_nested_set
  
  # validates :short_title, :inn, :admin_id, :presence => true
  has_attached_file :logo, :styles => { :pdf => "120x70#" } 
  
  has_many :users
  
  def users_statement
    self.users.statement_approvers
  end
end