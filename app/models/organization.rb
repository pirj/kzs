class Organization < ActiveRecord::Base
  attr_accessible :title, :parent_id, :lft, :rgt, :logo,
                  :address, :phone, :mail, :director_id, :short_title, :inn, :admin_id
  acts_as_nested_set
  
  validates :short_title, :inn, :admin_id, :presence => true
  has_attached_file :logo, :styles => { :pdf => "120x70#" } 
end