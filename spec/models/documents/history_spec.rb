require 'spec_helper'

describe Documents::History do
  let(:accountable){ FactoryGirl.create(:mail) }
  let(:other_accountable) { FactoryGirl.create(:mail) }
  subject { Documents::History.new(accountable) }

  it('#flow') { subject.flow.should be_a Documents::Flow }

  it('#add_by_accountable') do
    expect{subject.add other_accountable}.to change{subject.flow.documents.count}.from(1).to(2 )
  end

  describe '#fetch_documents_for' do
    let(:sender)      { FactoryGirl.create :organization }
    let(:recipient)   { FactoryGirl.create :organization }
    let(:accountable) do
      mail = FactoryGirl.create :mail
      mail.sender_organization = sender
      mail.recipient_organization = recipient
      mail.save!
      mail
    end
    let(:history)     { Documents::History.new(accountable) }
    before do

      @not_matching = FactoryGirl.create :mail
      @not_matching.tap do |mail|
        mail.sender_organization = sender
        mail.recipient_organization = recipient
        mail.save!
        mail.transition_to!(:prepared)
        mail.transition_to!(:approved)
        mail.transition_to!(:sent)
      end

      @matching = FactoryGirl.create :mail
      @matching.tap do |mail|
        mail.sender_organization = sender
        mail.recipient_organization = recipient
        mail.save!
        mail.transition_to!(:prepared)
        mail.transition_to!(:approved)
        mail.transition_to!(:sent)
      end

      @not_approved = FactoryGirl.create :mail
      @not_approved.tap do |mail|
        mail.sender_organization = recipient
        mail.recipient_organization = sender
        mail.save!
        mail.transition_to!(:prepared)
      end

      @not_sent = FactoryGirl.create :mail
      @not_sent.tap do |mail|
        mail.sender_organization = recipient
        mail.recipient_organization = sender
        mail.save!
        mail.transition_to!(:prepared)
        mail.transition_to!(:approved)
      end

      history.add @matching
      history.add @not_sent
      history.add @not_approved

    end

    subject { history.fetch_documents_for(sender) }

    it{ should include @matching.document }
    it{ should_not include @not_matching.document }
    it{ should_not include @not_sent.document }
    it{ should_not include @not_approved.document }
  end

end
