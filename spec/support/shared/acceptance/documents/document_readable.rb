# дополнительный перевод статусов,когда документо прочтен
shared_examples_for 'document_readable' do
  describe 'displayning "read" state when document has been opened by recipient director' do

    subject do
      within '.spec-doc-state-field' do
        page
      end
    end

    # важно,тут должен быть ДИРЕКТОР (director), потому что когда он открывает документ,то перевод меняется на прочитан
    let(:sender_user) { accountable.sender_organization.director }
    let(:recipient_user) { accountable.recipient_organization.director }

    background do
      accountable.transition_to!(:draft)
      accountable.transition_to!(:prepared)
      accountable.transition_to!(:approved)
      accountable.transition_to!(:sent)
      visit show_path
      sign_in_with user.email
    end

    context 'recipient user' do
      let(:user) { recipient_user }
      it { should have_content(/Прочитан/) }
    end


  end
end
