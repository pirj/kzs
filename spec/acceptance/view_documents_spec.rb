require 'acceptance/acceptance_helper'

feature 'User cam manage documents from documents list', %q() do

  let(:root) { root_path }
  let(:doc_page_path) { documents_path }
  let!(:user) { FactoryGirl.create(:user) }
  describe 'documents list' do

    scenario 'visit documents list page' do
      visit doc_page_path
      sign_in_with user.email, 'password'
      expect(page).to have_content('Документы')
    end

  end

end
