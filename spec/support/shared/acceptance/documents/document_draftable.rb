# область видимости подготовленного документа
# list_path — ссылка на список документов
# document — документ, с которым работаем
shared_examples_for 'document_draftable' do

  describe 'list drafts' do
    subject { page }

    background do
      sign_out
      visit list_path
      sign_in_with user.email, 'password'
      puts "signed in with a user #{user.id}"
      puts "document authored by #{document.creator_id}"
    end


    context 'to Author' do
      let(:user){ document.creator }
      it { should have_content document.title }
    end

    context 'to Saboteur' do
      let(:user){ FactoryGirl.create(:user, organization: document.sender_organization) }
      it { should_not have_content document.title }
    end
  end

  describe 'show' do
    subject { page }
    background do
      sign_out
      visit "/documents/mails/#{document.id}"
      sign_in_with user.email, 'password'
    end

    context 'to Author' do
      let(:user) { document.creator }
      it { should have_selector('h1', text: document.title) }
    end

    context 'to Saboteur' do
      let!(:user) { FactoryGirl.create(:user, organization: document.sender_organization) }
      its(:current_path) { should match '/documents' }
      it{ should have_selector('.alert.alert-danger', text: 'Недостаточно прав на чтение документа') }
    end
  end
end
