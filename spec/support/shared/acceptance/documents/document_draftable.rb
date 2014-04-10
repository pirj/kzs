# область видимости подготовленного документа
# index_path — ссылка на список документов
# show_path — ссылка на документ
# accountable — документ, с которым работаем
shared_examples_for 'document_draftable' do

  describe 'displaying drafted documents in general list' do
    subject { page }

    background do
      sign_out
      visit index_path
      sign_in_with user.email
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

  describe 'allow to open document-page' do
    subject { page }
    background do
      sign_out
      visit show_path
      sign_in_with user.email
    end

    context 'to Author' do
      let(:user) { accountable.creator }
      it { should have_content accountable.title }
    end

    context 'to Saboteur' do
      let!(:user) { FactoryGirl.create(:user, organization: accountable.sender_organization) }
      its(:current_path) { should match '/documents' }
      it{ should have_selector('.alert.alert-danger', text: 'Недостаточно прав на чтение документа') }
    end
  end
end
