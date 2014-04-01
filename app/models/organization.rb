# encoding: utf-8
# where is rspec???
class Organization < ActiveRecord::Base
  attr_accessible :title, :short_title, :inn,
                  :lft, :rgt,
                  :phone, :mail,:tax_authority_that_registered,
                  :parent_id,
                  :director_id,
                  :admin_id,
                  :accountant_id,
                  :bank_correspondent_account, :organization_account,
                  :date_of_registration, :creation_resolution_date, :egrul_registration_date,
                  :legal_address, :actual_address, :bank_address,
                  :type_of_ownership,
                  :certificate_of_tax_registration, :creation_resolution, :articles_of_organization, :logo, :egrul_excerpt,
                  :kpp, :ogrn, :bik, :ogrn, :bik,
                  :bank_bik, :bank_inn, :bank_kpp, :bank_okved, :bank_title,
                  :licenses_attributes

  acts_as_nested_set


  #validates :admin_id, :accountant_id, :director_id, presence: true
  #validates :short_title, :inn, :admin_id, :presence => true

  has_attached_file :logo, :plugins => { :pdf => "120x70#" }, :styles => { :medium => "300x300>"}
  has_attached_file :certificate_of_tax_registration
  has_attached_file :creation_resolution
  has_attached_file :articles_of_organization
  has_attached_file :egrul_excerpt

  has_many :users
  has_many :licenses, dependent: :destroy

  belongs_to :director, foreign_key: :director_id, class_name: 'User'
  belongs_to :accountant, foreign_key: :accountant_id, class_name: 'User'
  belongs_to :admin, foreign_key: :admin_id, class_name: 'User'

  TYPEOFOWNERSHIP = [I18n::translate('activerecord.attributes.organization.llc'), I18n::translate('activerecord.attributes.organization.businessman')]

  accepts_nested_attributes_for :licenses, allow_destroy: true

  def director?(user)
    director && director == user
  end

  def users_statement
    self.users.statement_approvers
  end


end