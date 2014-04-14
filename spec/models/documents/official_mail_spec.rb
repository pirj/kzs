require 'spec_helper'

describe Documents::OfficialMail do
  context 'common document interface' do
    subject { build(:mail) }
    it("#title should respond") { expect { subject.title }.to_not raise_error }
    it("#body should respond") { expect { subject.body }.to_not raise_error }
    it("#recipient_organization should respond") { expect { subject.recipient_organization }.to_not raise_error }
    it("#sender_organziation should respond") { expect { subject.sender_organization }.to_not raise_error }
  end

  context 'approvable' do
    let(:accountable){ create(:mail) }

    it_should_behave_like 'Approvable Document'

  end

  context 'without recipients' do
    subject { build(:mail_without_recipient) }
    it { should_not be_valid }
  end

  context 'with one direct recipient' do
    subject { build(:mail) }
    it { should be_valid }
  end

  context 'with many recipients' do
    subject { build(:mail_with_many_recipients) }
    it { should be_valid }
  end

  context 'mail multiplication' do
    let(:mail) { create(:mail_with_many_recipients) }
    before { mail.transition_to!(:prepared) }

    context 'when being approved' do
      it 'should create additional mail records' do
        recipients_count = mail.recipients.count
        incrementation = recipients_count - 1
        expect { mail.transition_to!(:approved) }.to change { Documents::OfficialMail.count }.by(incrementation)
      end

      it 'should create additional transactions' do
        transition_count = mail.document_transitions.count
        recipients_count = mail.recipients.count
        incrementation = (transition_count * (recipients_count - 1) + recipients_count)
        expect { mail.transition_to!(:approved) }.to change { DocumentTransition.count }.by(incrementation)
      end
    end

    context 'after transition' do
      before { mail.transition_to!(:approved) }

      context 'original mail' do
        subject { mail }
        its(:serial_number) { should_not be_nil }
        its(:approved_at) { should_not be_nil }
      end

      it 'should assign timestamp to all cloned documents' do
        Document.where(state: 'approved').pluck(:approved_at).all?.should be_true
      end

      it 'should assign serial_number to all cloned documents' do
        Document.where(state: 'approved').pluck(:serial_number).all?.should be_true
      end
    end
  end

end
