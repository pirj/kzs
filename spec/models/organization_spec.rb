require 'spec_helper'

describe Organization do

  context 'mass assignment attributes' do
    [:title, :short_title, :inn,:lft, :rgt, :phone, :official_mail,:tax_authority_that_registered, :parent_id, :director_id, :admin_id,
      :accountant_id, :bank_correspondent_account, :organization_account, :date_of_registration, :creation_resolution_date,
      :egrul_registration_date, :legal_address, :actual_address, :bank_address, :type_of_ownership, :certificate_of_tax_registration,
      :creation_resolution, :articles_of_organization, :logo, :egrul_excerpt, :kpp, :ogrn, :bik, :ogrn, :bik,:bank_bik, :bank_inn,
      :bank_kpp, :bank_okved, :bank_title]
    .map{|field| it {should allow_mass_assignment_of(field)}}
  end

  context 'associations' do
    [:director, :accountant, :admin].map{|field| it {should belong_to(field).class_name('User')}}
    it { should have_many :users }
    it { should have_many(:licenses).dependent(:destroy) }
    it { should accept_nested_attributes_for(:licenses) }
  end

  context 'attached files' do
    [:logo, :certificate_of_tax_registration, :creation_resolution, :articles_of_organization, :egrul_excerpt]
    .map{|field|it { should have_attached_file(field) } }
  end

end
