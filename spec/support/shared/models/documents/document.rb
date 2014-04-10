# область видимости подготовленного документа
# accountable — документ, с которым работаем
# должен быть в состоянии prepared
shared_examples_for 'Approvable Document' do
  before { accountable.transition_to! :prepared }

  describe '#can_transition_to? :approved' do
    subject { accountable.can_transition_to? :approved }

    context 'conformations pending' do
      before { Document.any_instance.stub(approvable?: false) }
      it { should be_false }
    end

    context 'conformations recieved' do
      before { Document.any_instance.stub(approvable?: true) }
      it { should be_true }
    end
  end

  describe '#approvable?' do
    subject { accountable.approvable? }
    let(:user){ create(:user) }

    context 'no conformers' do
      it{ should be true}
    end

    context 'conformers' do
      before do
        accountable.conformers.delete_all
        accountable.conformers << create(:user)
      end

      context 'unconformed' do
        it{should be false}
      end

      context 'conformed' do
        let(:conformation) { Conformation.new(user_id: accountable.conformers.first.id, conformed: true)}
        before { accountable.conformations << conformation }
        it{should be true}
      end
    end



  end
end
