class License < ActiveRecord::Base
  attr_accessible :typeof, :number, :issuance, :deadline, :issued_by, :image, :organization_id

  belongs_to :organization

  has_attached_file :image, :styles => { :medium => "300x300>"}

  TYPE_OF = ['Лицензия', 'Сертификат']
end
