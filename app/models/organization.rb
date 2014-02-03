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
                  :bank_bik, :bank_inn, :bank_kpp, :bank_okved, :bank_title

  acts_as_nested_set


  # validates :short_title, :inn, :admin_id, :presence => true
  has_attached_file :logo, :plugins => { :pdf => "120x70#" }, :styles => { :medium => "300x300>"}
  has_attached_file :certificate_of_tax_registration
  has_attached_file :creation_resolution
  has_attached_file :articles_of_organization
  has_attached_file :egrul_excerpt

  has_many :users
  has_many :licenses

  # TODO: @neodelf
  # true way is put next russian words into locales (I18n)
  # for example in locales/model/organization.ru.yml
  TYPEOFOWNERSHIP = [I18n::translate('activerecord.attributes.organization.llc'), I18n::translate('activerecord.attributes.organization.businessman')]

  # TODO: @neodelf
  # where is the nested_attributes for :licenses
  # read http://api.rubyonrails.org/classes/ActiveRecord/NestedAttributes/ClassMethods.html
  # and view http://railscasts.com/episodes?utf8=%E2%9C%93&search=nested+attributes
  accepts_nested_attributes_for :licenses, allow_destroy: true


  def director
    User.find(self.director_id) if self.director_id
  end

  def accountant
    User.find(self.accountant_id) if self.accountant_id
  end

  def admin
    User.find(self.admin_id) if self.admin_id
  end


  def users_statement
    self.users.statement_approvers
  end
end