require 'acceptance/acceptance_helper'

feature "Users may authenitacting", %q{} do

  let(:path) { root_path }
  let!(:user) {FactoryGirl.create(:user)}
  
  describe 'not authenticate for unregisterable user' do
    it 'should not authennticate with unregistarable user' do
      visit path

      sign_in_with 'user', 'user'

      expect(page).to have_content('Авторизуйтесь, пожалуйста')
    end
  end
  describe ' authenticate for registered user' do
    it 'should authenticate ' do
      visit path
      sign_in_with user.email, "password"
      expect(page).to have_content('Главный рабочий стол')
    end
  end


end