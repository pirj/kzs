# варианты переовода статуса 'sent' в зависимости от того,какая сторона просматривает документ
shared_examples_for 'sent_state_translatable' do
  describe 'special translates for sent documents for recipient and sender' do

    subject do
      within '.spec-doc-state-field' do
        page
      end
    end

    # важно,тут не должен быть ДИРЕКТОР (director), потому что когда он открывает документ,то перевод меняется на прочитан
    let(:sender_user) { accountable.sender_organization.admin }
    let(:recipient_user) { accountable.recipient_organization.admin }

    background do
      accountable.transition_to!(:draft)
      accountable.transition_to!(:prepared)
      accountable.transition_to!(:approved)
      accountable.transition_to!(:sent)
      visit show_path
      sign_in_with user.email
    end

    scenario 'should not equals recipient-user and sender-user' do
      expect(sender_user).to_not eq recipient_user
    end

    context 'sender user' do
      let(:user) { sender_user }
      it { should have_content(/Отправлен/) }
    end

    context 'recipient user' do
      let(:user) { recipient_user }
      it { should have_content(/Получен/) }
    end

  end
end
