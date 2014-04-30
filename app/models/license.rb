# coding: utf-8
# TODO: @neodelf
# where is rspec???
class License < ActiveRecord::Base
  attr_accessible :type_of, :number, :issuance, :deadline, :issued_by, :image, :organization_id

  belongs_to :organization

  has_attached_file :image, :styles => { :medium => "300x300>"}

  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/gif', 'image/png']

  TYPE_OF = ['Лицензия', 'Сертификат']
end
