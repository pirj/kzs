require 'spec_helper'

describe Documents::OfficialMail do
  let(:mail){ Documents::OfficialMail.make! }
  before { mail.transition_to!(:prepared) }
  context 'with 3 recipients' do

    context 'when being approved' do
      it 'should create additional mail records' do
        expect{mail.transition_to!(:approved)}.to change{Documents::OfficialMail.count}.by(2)
      end

      it 'should create additional transactions' do
        expect{mail.transition_to!(:approved)}.to change{DocumentTransition.count}.by(7)
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
