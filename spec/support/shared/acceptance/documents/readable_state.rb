# дополнительный перевод статусов,когда документо прочтен
# TODO-justvitalius: этот тест проверяет не то,что нужно.
shared_examples_for 'readable_state' do
  describe 'displayning "read" state when document has been opened by recipient director' do
    background do
      document.transition_to!(:draft)
      document.transition_to!(:prepared)
      document.transition_to!(:approved)
      document.transition_to!(:sent)
      visit path
    end

    scenario 'should not equals recipient-user and sender-user' do
      expect(sender_user).to_not eq recipient_user
    end

    context 'user from sender organization' do
      background do
        page.driver.submit :delete, destroy_user_session_path, {}
        visit path
        sign_in_with sender_user.email, 'password'
      end

      scenario 'render sender-state name' do
        within '.spec-doc-state-field' do
          expect(page).to have_content(/Отправлен/)
        end
      end
    end

    context 'user from recipient organization' do
      background do
        sign_out
        visit path
        sign_in_with recipient_user.email, 'password'
      end

      scenario 'should render recipient-state name' do
        within '.spec-doc-state-field' do
          expect(page).to have_content(/Получен/)
        end
      end
    end

  end
end
