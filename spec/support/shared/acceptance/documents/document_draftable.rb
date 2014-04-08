# область видимости подготовленного документа
# list_path — ссылка на список документов
# accountable — документ, с которым работаем
shared_examples_for 'document_draftable' do

  describe 'list drafts' do
    subject { page }

    background do
      sign_out
      visit list_path
      sign_in_with user.email, 'password'
      puts "signed in with a user #{user.id}"
      puts "document authored by #{accountable.creator_id}"
    end


    context 'to Author' do
      let(:user){ accountable.creator }
      it { should have_content accountable.title }
    end

    context 'to Saboteur' do
      let(:user){ FactoryGirl.create(:user, organization: accountable.sender_organization) }
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

    context 'to Author' do
      let(:user) { accountable.creator }
      it { should have_selector('h1', text: accountable.title) }
    end

    context 'to Saboteur' do
      let!(:user) { FactoryGirl.create(:user, organization: accountable.sender_organization) }
      its(:current_path) { should match '/documents' }
      it{ should have_selector('.alert.alert-danger', text: 'Недостаточно прав на чтение документа') }
    end
  end
end
