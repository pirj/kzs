require 'spec_helper'

describe Organization do
  subject { described_class.make! }

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


  context 'check scopes' do
    let!(:category_1) {Category.make!}
    let!(:category_2) {Category.make!}
    let!(:post_with_text) {Post.make!(subject: 'Subject', body: 'Body', category: category_1, created_at: Time.now)}
    let!(:post_with_category) {Post.make!(subject: 'Petya', body: 'Bankin', category: category_2, created_at: Time.now + 1.hour)}
    it 'with_text' do
      Post.with_text('ody').should == [post_with_text]
    end
    it 'with_category' do
      Post.with_category(category_2.id).should == [post_with_category]
    end
    it 'with_sort' do
      Post.with_sort('asc').last.should == post_with_category
    end
  end
end
