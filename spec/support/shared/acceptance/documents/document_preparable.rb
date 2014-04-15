# область видимости подготовленного документа
# index_path — ссылка на список документов
# show_path — ссылка на документ
# document — документ, с которым работаем
shared_examples_for 'document_preparable' do
  describe 'works with document in prepare state' do

    let(:creator) { accountable.creator }
    let(:approver) { accountable.approver }
    let(:executor) { accountable.executor }
    let(:conformer) { accountable.conformers.try(:first) }

    background do
      accountable.transition_to!(:draft)
      accountable.transition_to!(:prepared)
    end

    scenario 'document have conformers' do
      expect(accountable.conformers.count).to_not eq 0
    end

    describe 'displaying prepared documents in general list' do

      subject { page }

      background do
        visit index_path
        sign_in_with user.email

        expect(current_path).to eq index_path
      end

      [:executor, :approver, :creator, :conformer].each do |_user|
        context _user do
          let(:user) { send(_user.to_sym) }
          it { should have_content accountable.title }
        end
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

    describe 'allow to open document-page' do
      subject { page }
      background do
        visit show_path
        sign_in_with user.email
      end

      [:approver, :creator, :executor, :conformer].each do |user|
        context user.to_s do
          let!(:user) { send(user) }
          it { should have_selector('h1', text: accountable.title) }
        end
      end

      context 'saboteur' do
        let!(:user) { FactoryGirl.create(:user, organization: approver.organization) }
        it { should_not have_selector('h1', text: accountable.title) }
        it{ should have_selector('.alert.alert-danger', text: 'Недостаточно прав на чтение документа') }
        its(:current_path) { should match '/documents' }
      end

      context 'next state action' do
        [:approver, :creator, :executor, :conformer].each do |user|
          context user.to_s do
            let!(:user) { send(user) }
            it { should_not have_selector('a', text: 'Подготовить') }
          end
        end
      end

    end

  end
end
