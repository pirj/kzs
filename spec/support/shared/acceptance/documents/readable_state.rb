shared_examples_for 'readable_state' do
  describe 'special translates for sent states for recipient and sender' do
    background do
      document.transition_to!(:draft)
      document.transition_to!(:prepared)
      document.transition_to!(:approved)
      document.transition_to!(:sent)
      visit path
    end

    it 'should not equals recipient-user and sender-user' do
      expect(sender_user).to_not eq recipient_user
    end

    context 'user from sender organization' do
      background do
        page.driver.submit :delete, destroy_user_session_path, {}
        visit path
        sign_in_with sender_user.email, 'password'
      end

      it 'should render sender-state name' do
        within '.spec-doc-state-field' do
          expect(page).to have_content 'отправлено'
        end
      end
    end

    context 'user from recipient organization' do
      background do
        sign_out
        visit path
        sign_in_with recipient_user.email, 'password'
      end

      it 'should render recipient-state name' do
        within '.spec-doc-state-field' do
          expect(page).to have_content 'получено'
        end
      end
    end

  end
end