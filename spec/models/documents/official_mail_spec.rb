require 'spec_helper'

describe Documents::OfficialMail do
  context 'common document interface' do
    subject { build(:mail) }
    it("#title should respond") { expect { subject.title }.to_not raise_error }
    it("#body should respond") { expect { subject.body }.to_not raise_error }
    it("#recipient_organization should respond") { expect { subject.recipient_organization }.to_not raise_error }
    it("#sender_organziation should respond") { expect { subject.sender_organization }.to_not raise_error }
  end

  context 'without recipients' do
    subject { build(:mail) }
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

  describe '#history_for' do

    let(:initial) { FactoryGirl.create(:approved_mail) }
    let(:reply) { FactoryGirl.create(:approved_mail) }
    let(:some_approved) { FactoryGirl.create(:approved_mail) }
    let(:reply_approved_not_sent) { FactoryGirl.create(:approved_mail) }
    let(:sndr) { FactoryGirl.create(:simple_organization) }
    let(:rsvr) { FactoryGirl.create(:simple_organization) }
    let(:conversation) { DocumentConversation.create! }

    before do
      initial.sender_organization = sndr
      initial.recipient_organization = rsvr
      initial.save!

      reply.sender_organization = rsvr
      reply.recipient_organization = sndr
      reply.save!
      reply.transition_to! :sent

      reply_approved_not_sent.sender_organization = rsvr
      reply_approved_not_sent.recipient_organization = sndr
      reply_approved_not_sent.save!

      conversation.official_mails << [initial, reply, reply_approved_not_sent]
    end

    subject { initial.history_for(sndr.id) }

    its(:count) { should be(2) }
    it { should include initial }
    it { should include reply }
    it { should_not include some_approved }
    it { should_not include reply_approved_not_sent }
  end
end
