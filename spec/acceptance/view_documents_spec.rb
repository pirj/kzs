require 'acceptance/acceptance_helper'

feature "List documents page correctly works", %q{} do

  let(:path) { root_path }

  describe 'not authenticate for unregisterable user' do
    it 'should not authennticate with unregistarable user' do
      visit path

      sign_in_with 'user', 'user'

      expect(page).to have_content('Авторизуйтесь, пожалуйста')
    end
  end


end