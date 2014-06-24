# область видимости подписанного документа
# index_path — ссылка на список документов
# show_path — ссылка на документ
# accountable — документ, с которым работаем
shared_examples_for 'document_approvable' do

  context 'document in approve state' do
    let(:approver) { accountable.approver }
    let(:creator) { accountable.creator }
    let(:executor) { accountable.executor }
    let(:sender_user) { FactoryGirl.create(:user, organization: accountable.sender_organization) }
    let(:recipient_user) { accountable.recipient_organization.director }

    background do
      accountable.transition_to!(:draft)
      accountable.transition_to!(:prepared)
      accountable.transition_to!(:approved)
    end

    describe 'displaying approved documents in general list' do
      subject { page }
      background do
        visit index_path
        sign_in_with user.email
      end

      context 'sender organization' do
        [:approver, :creator, :executor, :sender_user].each do |_user|
          context _user do
            let(:user) { send(_user) }
            it { should have_content document.title }
            end
          end
        end

      context 'recipient organization' do
        let(:user) { recipient_user}
        it { should_not have_content document.title}
      end
    end

    describe 'allow to open approved document-page' do
      subject { page }
      background do
        visit show_path
        sign_in_with user.email
      end

      context 'sender organization' do

        background do
          expect(current_path).to eq show_path
        end

        [:approver, :creator, :executor, :sender_user].each do |_user|
          context _user do
            let(:user) { send(_user) }
            it { should have_selector('h1', text: document.title) }
          end
        end

      end

      context 'recipient organization' do
        let(:user) { recipient_user}
        its(:current_path) { should match '/documents' }
        it { should_not have_selector('h1', text: document.title) }
        it { should have_selector('.alert.alert-danger', text: 'Недостаточно прав на чтение документа') }
      end

      context 'to sender organization Employee' do
        let!(:user) { FactoryGirl.create(:user, organization: accountable.sender_organization) }
        it { should have_selector('h1', text: accountable.title) }
      end

      context 'to other user' do
        let!(:user) { FactoryGirl.create(:user_with_organization) }
        its(:current_path) { should match '/documents' }
        it{ should have_selector('.alert.alert-danger', text: 'Недостаточно прав на чтение документа') }
      end
    end

    describe 'allow to make next-states for approved document' do
      subject { page }
      background do
        visit show_path
        sign_in_with user.email
      end

      context 'sender organization' do
        background do
          expect(current_path).to eq show_path
          expect(page).to_not have_content 'Недостаточно прав'
        end

        context 'approver' do
          let(:user) { approver }
          scenario 'hidding next-state button' do
            expect(page).to have_selector('a', text: 'Отправить')
          end
        end

        [:creator, :executor, :sender_user].each do |_user|
          context _user do
            let(:user) { send(_user.to_sym) }
            scenario 'hidding next-state button' do
              expect(page).to_not have_selector('a', text: 'Отправить')
            end
          end
        end
      end

      context 'recipient organization' do
        let(:user) { recipient_user }
        scenario 'not access to document next-state button' do
            expect(current_path).to eq index_path
            expect(page).to have_content 'Недостаточно прав'
            expect(page).to_not have_selector('a', text: 'Отправить')
          end
      end
    end
  end
end
