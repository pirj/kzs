require 'spec_helper'

describe Document do

  context 'when have conformations and being updated' do
    let(:mail) {FactoryGirl.create(:mail_with_direct_recipient_and_conformers)}
    let(:conformer) {mail.conformers.first}

    before :each do
      mail.conformers.first.conform mail
    end

    it "should clear its conformations" do
      mail.reload.conformations.count.should be > 0

      mail.title = '123'
      mail.save

      mail.reload.conformations.count.should == 0
    end

    it "should not clear other conformations" do
      mail2 = FactoryGirl.create(:mail_with_direct_recipient_and_conformers)
      mail2.conformers.first.conform mail2

      mail2.reload.conformations.count.should be > 0

      mail.title = '123'
      mail.save

      mail2.reload.conformations.count.should be > 0
    end
  end

  context "read/unread states"

    xit "should be able to be marked as read by reader, if unread"

    context "when created in state > draft and < sent" do

      xit "should be marked as read to sender"

      xit "should be unread by approver (if approver is not sender)"
      
      xit "should be unread by executor (if approver is not sender)"

      xit "should be unread by all conformers (if conformer is not sender)"
      
      xit "should be marked as read to sender if sender == approver"

      xit "should be marked as read to sender if sender == conformer"

      xit "should be marked as read to sender if sender == executor"

    end

    context "when in state >= sent" do
      xit "should be marked as unread to everybody in receiving organization"

      xit "it should be able to be readed"

    end
  end



end
