require 'spec_helper'

describe Organization do
  before { pending }

  context 'mass assignment attributes' do
    [:title, :short_title, :inn, :lft, :rgt, :phone, :mail, :tax_authority_that_registered, :parent_id, :director_id, :admin_id,
     :accountant_id, :bank_correspondent_account, :organization_account, :date_of_registration, :creation_resolution_date,
     :egrul_registration_date, :legal_address, :actual_address, :bank_address, :type_of_ownership, :certificate_of_tax_registration,
     :creation_resolution, :articles_of_organization, :logo, :egrul_excerpt, :kpp, :ogrn, :bik, :ogrn, :bik, :bank_bik, :bank_inn,
     :bank_kpp, :bank_okved, :bank_title]
    .map { |field| it { should allow_mass_assignment_of(field) } }
  end

  context 'associations' do
    [:director, :accountant, :admin].map { |field| it { should belong_to(field).class_name('User') } }
    it { should have_many :users }
    it { should have_many(:licenses).dependent(:destroy) }
    it { should accept_nested_attributes_for(:licenses) }
  end

  context 'attached files' do
    [:logo, :certificate_of_tax_registration, :creation_resolution, :articles_of_organization, :egrul_excerpt]
    .map { |field|it { should have_attached_file(field) } }
  end

  context 'validate' do
    it { should validate_presence_of(:admin_id) }
    it { should validate_presence_of(:accountant_id) }
    it { should validate_presence_of(:director_id) }
  end

  context 'valid string type fields' do
    it { should have_db_column(:title).of_type(:string) }
  end

  context 'valid string type fields' do
    [:title, :logo_file_name, :logo_content_type, :phone, :mail, :inn, :short_title, :type_of_ownership, :legal_address, :actual_address,
     :tax_authority_that_registered, :certificate_of_tax_registration_file_name, :certificate_of_tax_registration_content_type,
     :creation_resolution_file_name, :creation_resolution_content_type, :articles_of_organization_file_name,
     :articles_of_organization_content_type, :phone, :mail, :kpp, :ogrn, :bik, :egrul_excerpt_file_name, :egrul_excerpt_content_type,
     :bank_title, :bank_address, :bank_correspondent_account, :bank_bik, :bank_inn, :bank_kpp, :bank_okved, :organization_account]
    .map { |field| it { have_db_column(field).of_type(:string) } }
  end

  context 'valid integer type fields' do
    [:parent_id, :lft, :rgt, :logo_file_size, :director_id, :admin_id, :certificate_of_tax_registration_file_size, :creation_resolution_file_size,
     :articles_of_organization_file_size, :accountant_id, :egrul_excerpt_file_size]
    .map { |field| it { have_db_column(field).of_type(:integer) } }
  end
  context 'valid datetime type fields' do
    [:created_at, :updated_at, :logo_updated_at, :date_of_registration, :certificate_of_tax_registration_updated_at, :creation_resolution_date,
     :creation_resolution_updated_at, :articles_of_organization_updated_at, :egrul_excerpt_updated_at]
    .map { |field| it { have_db_column(field).of_type(:datetime) } }
  end

  context 'valid date type fields' do
    [:egrul_registration_date]
    .map { |field| it { have_db_column(field).of_type(:date) } }
  end
end
