require 'acceptance/acceptance_helper'

feature "List documents page correctly works", %q{} do

  let(:root) { root_path }
  let(:doc_page_path) {documents_documents_path}
  let!(:user) {FactoryGirl.create(:user)}
  describe 'mail has a button to answer' do


    it 'view documents page opened' do
      visit doc_page_path
      sign_in_with user.email, "password"
      #visit docPage
      expect(page).to have_content('Документы')
    end


  end


end