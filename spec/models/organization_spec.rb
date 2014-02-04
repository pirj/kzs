require 'spec_helper'

describe Organization do
  #subject { described_class.make! }

  context 'mass assignment attributes' do
    [:title, :short_title, :inn,:lft, :rgt, :phone, :mail,:tax_authority_that_registered, :parent_id, :director_id, :admin_id,
      :accountant_id, :bank_correspondent_account, :organization_account, :date_of_registration, :creation_resolution_date,
      :egrul_registration_date, :legal_address, :actual_address, :bank_address, :type_of_ownership, :certificate_of_tax_registration,
      :creation_resolution, :articles_of_organization, :logo, :egrul_excerpt, :kpp, :ogrn, :bik, :ogrn, :bik,:bank_bik, :bank_inn,
      :bank_kpp, :bank_okved, :bank_title]
    .map{|field| it {should allow_mass_assignment_of(field)}}
  end

  context 'associations' do
    it { should have_many :users }
    it { should have_many :licenses }
  end

  context 'check methods:' do
    let!(:organization) {Organization.make!}
    it 'director' do
      organization.director.id == organization.director_id
    end
  end
end
