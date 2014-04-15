require 'acceptance/acceptance_helper'

feature "User login/unlogin", %q() do

  let(:user) { FactoryGirl.create(:user) }
  let(:path) { root_path }

  describe 'User sign in', js: true do
    scenario 'success' do
      visit path
      sign_in_with user.email, 'password'
      expect(page).to have_content 'сейчас вы будете автоматически'
      sleep(10)
      #page.save_screenshot('test_images/testimage.png', full: true)
      expect(page).to_not have_content 'сейчас вы будете автоматически'
      expect(page).to have_content 'Главный рабочий стол'
      expect(page).to_not have_content 'Неверное имя пользователя или пароль.'
    end

    scenario 'failed' do
      visit path
      sign_in_with user.email, 'passw2ord'
      expect(page).to have_content 'Неверное имя пользователя или пароль.'
      expect(current_path).to_not eq root_path
    end

  end
end

