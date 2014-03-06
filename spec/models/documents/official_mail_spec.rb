require 'spec_helper'

describe Documents::OfficialMail do
  context 'without recipients' do
    subject { build(:mail)}
    it { should_not be_valid }
  end

  context 'with one direct recipient' do
    subject { build(:mail_with_direct_recipient) }
    it { should be_valid }
  end

  context 'with many recipients' do
    subject { build(:mail_with_many_recipients) }
    it { should be_valid }
  end

  context 'mail multiplication' do
    let(:mail){ create(:mail_with_many_recipients) }
    before { mail.transition_to!(:prepared) }


    context 'when being approved' do
      it 'should create additional mail records' do
        recipients_count = mail.recipients.count
        incrementation = recipients_count - 1
        expect{mail.transition_to!(:approved)}.to change{Documents::OfficialMail.count}.by(incrementation)
      end

      it 'should create additional transactions' do
        transition_count = mail.document_transitions.count
        recipients_count = mail.recipients.count
        incrementation = (transition_count * (recipients_count - 1) + recipients_count)
        expect{mail.transition_to!(:approved)}.to change{DocumentTransition.count}.by(incrementation)
      end
    end

    context 'after transition' do
      before{ mail.transition_to!(:approved)}

      context 'original mail' do
        subject{mail}
        its(:serial_number){should_not be_nil}
        its(:approved_at){should_not be_nil}
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
