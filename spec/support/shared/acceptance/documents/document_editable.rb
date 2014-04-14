# ситуации,когда документ можно редактировать
# переменные необходимые для спеки
# accountable — полиморф-документ типа [Documents::OfficalMail]
# document — документ типа [Document]
# show_path — линк на show-метод документа
shared_examples_for 'document_editable' do
  describe 'allow to edit document before approve or sent' do

    subject { page }

    let(:creator) { document.creator }
    let(:approver) { document.approver }
    let(:executor) { document.executor }
    let(:admin) { document.sender_organization.admin }
    let(:director) { document.sender_organization.director }
    let(:sender_user) { FactoryGirl.create(:user, organization: document.sender_organization) }

    background do
      visit show_path
      sign_in_with user.email
    end



    context 'draft state' do
      context 'user as a document creator' do
        let(:user) { accountable.creator }
        it { should have_selector('a', text: 'Редактировать') }
      end

      [:approver, :executor, :admin, :director, :sender_user].each do |_user|
        context "user as a document #{_user}" do
          let(:user) { send(_user.to_sym) }
          it { should_not have_content 'Редактировать' }
        end
      end
    end

    context 'prepared state' do
      background do
        accountable.transition_to!(:draft)
        accountable.transition_to!(:prepared)
        visit show_path
      end

      [:creator, :approver, :executor].each do |_user|
        context "user as a document #{_user}" do
          let(:user) { send(_user.to_sym) }
          it { should have_selector('a', text: 'Редактировать') }
        end
      end

      [:admin, :director, :sender_user].each do |_user|
        context "user as a document #{_user}" do
          let(:user) { send(_user.to_sym) }
          it { should_not have_content 'Редактировать' }
        end
      end
    end

    context 'approved state' do
      background do
        accountable.transition_to!(:draft)
        accountable.transition_to!(:prepared)
        accountable.transition_to!(:approved)
        visit show_path
      end

      [:creator, :approver, :executor, :admin, :director, :sender_user].each do |_user|
        context "user as a document #{_user}" do
          let(:user) { send(_user.to_sym) }
          it { should_not have_content 'Редактировать' }
        end
      end

    end

    context 'sent state' do
      background do
        accountable.transition_to!(:draft)
        accountable.transition_to!(:prepared)
        accountable.transition_to!(:approved)
        accountable.transition_to!(:sent)
        visit show_path
      end

      [:creator, :approver, :executor, :admin, :director, :sender_user].each do |_user|
        context "user as a document #{_user}" do
          let(:user) { send(_user.to_sym) }
          it { should_not have_content 'Редактировать' }
        end
      end
    end

  end
end
