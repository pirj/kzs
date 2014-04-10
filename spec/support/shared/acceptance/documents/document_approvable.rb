# область видимости подготовленного документа
# index_path — ссылка на список документов
# show_path — ссылка на документ
# accountable — документ, с которым работаем
shared_examples_for 'document_approvable' do

  describe 'displaying approved documents in general list' do
    subject { page }

    background do
      sign_out
      visit index_path
      sign_in_with user.email
    end


    context 'sender oranization Employee' do
      let(:user){ FactoryGirl.create(:user, organization: accountable.sender_organization)}
      it { should have_content accountable.title }
    end

    context 'other user' do
      let(:user){ FactoryGirl.create(:user) }
      it { should_not have_content accountable.title }
    end
  end

  describe 'allow to open document-page' do
    subject { page }
    background do
      sign_out
      visit show_path
      sign_in_with user.email
    end

    context 'to sender organization Employee' do
      let!(:user) { FactoryGirl.create(:user, organization: accountable.sender_organization) }
      it { should have_selector('h1', text: accountable.title) }
    end

    context 'to other user' do
      let!(:user) { FactoryGirl.create(:user) }
      its(:current_path) { should match '/documents' }
      it{ should have_selector('.alert.alert-danger', text: 'Недостаточно прав на чтение документа') }
    end
  end
end
