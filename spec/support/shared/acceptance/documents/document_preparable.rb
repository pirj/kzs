# область видимости подготовленного документа
# list_path — ссылка на список документов
# document — документ, с которым работаем
shared_examples_for 'document_preparable' do

  describe 'allow view prepared document in documents list' do

    subject { page }

    let!(:approver) { document.approver }
    let!(:creator) { document.creator }
    let!(:executor) { document.executor }
    let!(:conformer) { document.conformers.first }
    let!(:another_user) { FactoryGirl.create(:user, organization: approver.organization) }

    background do
      sign_out
      visit list_path
      sign_in_with user.email, 'password'

      expect(current_path).to eq list_path
    end

    context 'executor' do
      let!(:user) { document.executor }

      it { should have_content document.title }
    end

    context 'approver' do
      let!(:user) { document.approver }
      it { should have_content document.title }
    end

    context 'creator' do
      let!(:user) { document.creator }

      it { should have_content document.title }
    end

    context 'conformers' do
      let!(:user) { document.conformers.first }

      it { should have_content document.title }
    end

    context 'another user' do
      let!(:user) { FactoryGirl.create(:user, organization: document.sender_organization) }

      it { should_not have_content document.title }
    end

    context 'recipient user' do
      let!(:user) { document.recipient_organization.director }

      it { should_not have_content document.title }
    end

  end
end
