# варианты переовода статуса 'sent' в зависимости от того,какая сторона просматривает документ
shared_examples_for 'sent_state_translatable' do
  describe 'special translates for sent states for recipient and sender' do

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
        sign_out
        visit path
        sign_in_with sender_user.email, 'password'
      end

      scenario 'should render sender-state translate' do
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

      scenario 'should render recipient-state translate' do
        within '.spec-doc-state-field' do
          expect(page).to have_content(/Получен/)
        end
      end
    end
  end
end
