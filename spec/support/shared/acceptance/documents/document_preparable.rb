# область видимости подготовленного документа
# index_path — ссылка на список документов
# show_path — ссылка на документ
# document — документ, с которым работаем
shared_examples_for 'document_preparable' do

  describe 'allow view prepared document in documents list' do

    subject { page }

    let!(:approver) { accountable.approver }
    let!(:creator) { accountable.creator }
    let!(:executor) { accountable.executor }
    let!(:conformer) { accountable.conformers.first }
    let!(:another_user) { FactoryGirl.create(:user, organization: approver.organization) }

    background do
      sign_out
      visit index_path
      sign_in_with user.email, 'password'

      expect(current_path).to eq index_path
    end

    context 'executor' do
      let!(:user) { accountable.executor }

      it { should have_content accountable.title }
    end

    context 'approver' do
      let!(:user) { accountable.approver }
      it { should have_content accountable.title }
    end

    context 'creator' do
      let!(:user) { accountable.creator }

      it { should have_content accountable.title }
    end

    context 'conformers' do
      let!(:user) { accountable.conformers.first }

      it { should have_content accountable.title }
    end

    context 'another user' do
      let!(:user) { FactoryGirl.create(:user, organization: accountable.sender_organization) }

      it { should_not have_content accountable.title }
    end

    context 'recipient user' do
      let!(:user) { accountable.recipient_organization.director }

      it { should_not have_content accountable.title }
    end

  end
end
