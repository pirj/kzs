# coding: utf-8
module Features
  module SessionsHelper

    def sign_in_with(email, password='password')
      within '.spec-login-form' do
        fill_in 'user[login]', with: email
        fill_in 'user[password]', with: password
        # click_on "войти"
        click_on 'Вход'
      end
      # find('form').click('войти')
    end

    def sign_out
      page.driver.submit :delete, destroy_user_session_path, {}
    end

    def skip_welcome
      execute_script(%Q!$('.js-welcome-screen, .modal-backdrop-white').remove()!)
    end

    def sign_out_js
      skip_welcome
      find('.spec-user-logout').click
    end

  end
end
