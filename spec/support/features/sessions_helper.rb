module Features
  module SessionsHelper
    def sign_in_with(email, password)
      within '.spec-login-form' do
        fill_in 'user[login]', with: email
        fill_in 'user[password]', with: password
        #click_on "войти"
        click_on 'Вход'
      end
      #find('form').click('войти')
    end

    def prepare_testing_area
      visit path
      sign_in_with admin.email, '12345678'
    end
  end
end