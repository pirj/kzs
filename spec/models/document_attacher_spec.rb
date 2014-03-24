require 'spec_helper'

describe DocumentAttacher do
  before :all do
    @session = {}
  end

  xit "shoud be to clear the state (in session) for the current user and document" do
  end

  context "on initialize" do
    before :each do
      # @attacher = DocumentAttacher.new(document_id, session)
    end

    it "should accept document/accountable and a session on initialize" do
      mail = FactoryGirl.create(:mail_with_direct_recipient)
      expect {attacher = DocumentAttacher.new(mail, {})}.not_to raise_error
    end

    it "should raise ArgumentError if document sent is not a document/accountable" do
      expect {attacher = DocumentAttacher.new(1, {})}.to raise_error ArgumentError
    end

    xit "should remove any documents that can't be attached anymore from the attach list" do
    end

    xit "should remove non-existent and already detached documents from the detach list" do
    end
  end

  context "When pre-attaching a document" do
    it "should be able to pre-attach document (add to attach list)" do
      attachment = FactoryGirl.create(:mail_approved)
      document = FactoryGirl.create(:mail_with_direct_recipient)
      attacher = DocumentAttacher.new(document, @session)
      attacher.attach attachment

      attacher.pending_attaches.should include attachment.document.id
    end

    it "should not repeat attached id when attached single document several times" do
      attachment = FactoryGirl.create(:mail_approved)
      document = FactoryGirl.create(:mail_with_direct_recipient)
      attacher = DocumentAttacher.new(document, @session)
      3.times {attacher.attach attachment}

      attacher.pending_attaches.should include attachment.document.id
      attacher.pending_attaches.count(attachment.document.id).should == 1

    end

    it "should simply delete doc id from detach array, if attached document is in detach list" do
      accountable = FactoryGirl.create(:mail_with_attachment)
      attachment = accountable.attached_documents.first
      
      attacher = DocumentAttacher.new(accountable, @session)
      attacher.detach attachment
      attacher.attach attachment

      attacher.pending_detaches.should_not include attachment.id
    end
  end

  context "When pre-detaching a document" do
    it "should be able to pre-detach a document (add to detach list), if this is real attached document" do
      accountable = FactoryGirl.create(:mail_with_attachment)
      attachment = accountable.attached_documents.first
      
      attacher = DocumentAttacher.new(accountable, @session)
      attacher.detach attachment

      attacher.pending_detaches.should include attachment.id
    end

    it "if doc is listed in pending attaches, should simply delete doc from pending attaches and not add no detach array" do
      attachment = FactoryGirl.create(:mail_approved)
      accountable = FactoryGirl.create(:mail_with_direct_recipient)

      attacher = DocumentAttacher.new(accountable, @session)
      attacher.attach attachment
      attacher.detach attachment

      attacher.pending_attaches.should_not include attachment.document.id
      attacher.pending_detaches.should_not include attachment.document.id
    end
  end

  context "When confirming the action" do
    it "should attach all documents which are supporsed to be added (in attach list)" do
      attachment = FactoryGirl.create(:mail_approved)
      accountable = FactoryGirl.create(:mail_with_direct_recipient)

      attacher = DocumentAttacher.new(accountable, @session)
      attacher.attach attachment
      attacher.confirm

      accountable.attached_documents.should include Document.find(attachment.document.id)
    end

    it "should detach all documents which are supporsed to be detached (in detach list)" do
      accountable = FactoryGirl.create(:mail_with_attachment)
      attachment = accountable.attached_documents.first
      
      attacher = DocumentAttacher.new(accountable, @session)
      attacher.detach attachment
      attacher.confirm

      accountable.attached_documents.should_not include Document.find(attachment.id)
    end

    xit "should produce an error if any document were not attached" do
    end
  end

  context "When getting data from attacher" do
    xit "should provide valid list of currently attachable documents (in the middle of attach process)" do
    end

    xit "list of currently attachable documents (in the middle of attach process) shoudn't include draft or prepared docs" do
    end

    xit "should provide valid list of current (temporarily) attached documents" do
    end    
  end
end