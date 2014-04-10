# область видимости подготовленного документа
# index_path — ссылка на список документов
# show_path — ссылка на документ
# document — документ, с которым работаем
shared_examples_for 'document_preparable' do

  describe 'displaying prepared documents in general list' do

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


    describe 'allow to open document-page' do
      subject { page }
      background do
        sign_out
        visit show_path
        sign_in_with user.email
      end

      [:approver, :creator, :executor].each do |user|
        context user.to_s do
          let!(:user) { accountable.send(user) }
          it { should have_selector('h1', text: accountable.title) }
        end
      end

      context 'conformer' do
        let!(:user) { accountable.conformers.first }
        it { should have_selector('h1', text: accountable.title) }
      end

      context 'saboteur' do
        let!(:user) { FactoryGirl.create(:user, organization: approver.organization) }
        it { should_not have_selector('h1', text: accountable.title) }
        it{ should have_selector('.alert.alert-danger', text: 'Недостаточно прав на чтение документа') }
        its(:current_path) { should match '/documents' }
      end

    end
  end
end
