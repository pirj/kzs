# область видимости отправленного документа
# статус :sent
# index_path — ссылка на список документов
# show_path - ссылка на документ
# accountable — документ, с которым работаем
shared_examples_for 'document_sendable' do
  describe 'works with document in sent state' do

    background do
      accountable.transition_to!(:draft)
      accountable.transition_to!(:prepared)
      accountable.transition_to!(:approved)
      accountable.transition_to!(:sent)
    end

    describe 'displaying sent document in general list' do
      subject { page }

      background do
        visit index_path
        sign_in_with user.email
      end


      context 'sender organization Employee' do
        let(:user){ FactoryGirl.create(:user, organization: accountable.sender_organization)}
        it { should have_content accountable.title }
      end

      context 'recipient organization Employee' do
        let(:user){ FactoryGirl.create(:user, organization: accountable.recipient_organization)}
        it { should have_content accountable.title }
      end

      context 'other user' do
        let(:user){ FactoryGirl.create(:user_with_organization) }
        it { should_not have_content accountable.title }
      end
    end

    describe 'allow open sent document-page' do
      subject { page }
      background do
        sign_out
        visit show_path
        sign_in_with user.email
      end

      context 'to sender organization Employee' do
        let!(:user) { FactoryGirl.create(:user, organization: accountable.sender_organization) }

        # Место для теста на показ Согласующих Лиц
        # должны быть

        it { should have_content accountable.title }
      end

      context 'to recipient organization Employee' do
        let!(:user) { FactoryGirl.create(:user, organization: accountable.recipient_organization) }

        # Место для теста на показ Согласующих Лиц
        # их быть не должно

        it { should have_content accountable.title }
      end

      context 'to other user' do
        let!(:user) { FactoryGirl.create(:user_with_organization) }
        its(:current_path) { should match '/documents' }
        it{ should have_selector('.alert.alert-danger', text: 'Недостаточно прав на чтение документа') }
      end
    end

  end
end
