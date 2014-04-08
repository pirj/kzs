# область видимости подготовленного документа
# index_path — ссылка на список документов
# accountable — документ, с которым работаем
shared_examples_for 'document_sendable' do

  describe 'list drafts' do
    subject { page }

    background do
      sign_out
      visit list_path
      sign_in_with user.email, 'password'
    end


    context 'sender oranization Employee' do
      let(:user){ FactoryGirl.create(:user, organization: accountable.sender_organization)}
      it { should have_content accountable.title }
    end

    context 'recipient oranization Employee' do
      let(:user){ FactoryGirl.create(:user, organization: accountable.recipient_organization)}
      it { should have_content accountable.title }
    end

    context 'other user' do
      let(:user){ FactoryGirl.create(:user) }
      it { should_not have_content accountable.title }
    end
  end

  describe 'show' do
    subject { page }
    background do
      sign_out
      visit "/documents/mails/#{accountable.id}"
      sign_in_with user.email, 'password'
    end

    context 'to sender organization Employee' do
      let!(:user) { FactoryGirl.create(:user, organization: accountable.sender_organization) }

      # Место для теста на показ Согласующих Лиц
      # должны быть

      it { should have_selector('h1', text: accountable.title) }
    end

    context 'to recipient organization Employee' do
      let!(:user) { FactoryGirl.create(:user, organization: accountable.recipient_organization) }

      # Место для теста на показ Согласующих Лиц
      # их быть не должно

      it { should have_selector('h1', text: accountable.title) }
    end

    context 'to other user' do
      let!(:user) { FactoryGirl.create(:user) }
      its(:current_path) { should match '/documents' }
      it{ should have_selector('.alert.alert-danger', text: 'Недостаточно прав на чтение документа') }
    end
  end
end
