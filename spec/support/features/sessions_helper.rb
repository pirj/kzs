# coding: utf-8
module Features
  module SessionsHelper

    def sign_in_with(email, password='password')
      within '.spec-login-form' do
        fill_in 'user[login]', with: email
        fill_in 'user[password]', with: password
        click_on 'Вход'
      end
    end

    def sign_out
      if example.metadata[:js]
        sign_out_js
      else
        page.driver.submit :delete, destroy_user_session_path, {}
      end
    end

    def skip_welcome
      execute_script(%Q!$('.js-welcome-screen, .modal-backdrop-white').remove()!)
    end

    def sign_out_js
      skip_welcome
      visit destroy_user_session_path
    end

  end
end
