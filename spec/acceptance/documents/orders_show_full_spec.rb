require 'acceptance/acceptance_helper'

feature "Users review order", %q{} do

  let!(:user) { FactoryGirl.create(:user) }
  let!(:order) { FactoryGirl.create(:order) }
  let(:path) { root_path }

  describe 'not authenticate for unregisterable user'do
    it 'should not authennticate with unregistarable user' do
      visit path

      sign_in_with user.email, 'password'

      expect(current_path).to eq(path)
    end
  end



  let!(:user) { FactoryGirl.create(:user) }
  let!(:order) { FactoryGirl.create(:order) }

  describe 'executer custom placeholder', js: true do
    let(:path) { new_documents_order_path }

    it 'should be render custom placeholder' do
      visit path
      sign_in_with user.email, 'password'

      within '.spec-order-field-show' do
        expect(page).to have_content 'Нажмите галку, чтобы выбрать'
      end
    end
  end


end