require 'acceptance/acceptance_helper'

feature "User login/unlogin", %q() do

  let(:user) { FactoryGirl.create(:user) }
  let(:path) { new_user_session }

  describe 'User sign in', js: true do
    scenario 'success' do
      visit path
      sign_in_with user.email, 'password'
      expect(page).to have_content 'сейчас вы будете автоматически перенаправлены на страницу виджетов'
      expect(page).to_not have_content 'Неверное имя пользователя или пароль.'
      visit root
    end
    scenario 'failed' do
      visit path
      sign_in_with user.email, 'passw2ord'
      expect(page).to have_content 'Неверное имя пользователя или пароль.'
      expect(current_path).to_not eq root
    end
  end
end

