require 'spec_helper'

describe DocumentAttacher do
  before :all do
    @session = {}
  end

  it "shoud be able to clear the state (in session) for the current user and document" do
    accountable = FactoryGirl.create(:mail_with_attachment)
    existing_attachment = accountable.attached_documents.first
    attachment = FactoryGirl.create(:mail_approved)
    
    attacher = DocumentAttacher.new(accountable, @session)
    attacher.detach existing_attachment
    attacher.attach attachment

    attacher.clear

    attacher.pending_attaches.length.should == 0
    attacher.pending_detaches.length.should == 0
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

    # Мб несколько кейсов?
    xit "should correctly treat the situtation when document being attached can't be attached anymore (deleted, moved to drafts, etc.)" do
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

    # Мб несколько койсов?
    # Мб кейс про silently execution?
    xit "should correctly treat the situtation when document being detached can't be detached anymore (deleted, moved to drafts, etc.)" do
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

  # TODO: мб разбить тест на несколько?
  context "When getting list of currently attachable documents (in the middle of attach process)" do
    it "should provide valid list" do
      accountable = FactoryGirl.create(:mail_with_two_attachments)
      
      existing_attachments = [
        accountable.attached_documents.first,
        accountable.attached_documents.last
      ]
      
      new_attachments = [
        FactoryGirl.create(:mail_approved).document,
        FactoryGirl.create(:mail_approved).document
      ]
      
      attacher = DocumentAttacher.new(accountable, @session)
      attacher.detach existing_attachments[0]
      attacher.attach new_attachments[0]

      # Не должно быть самого документа
      attacher.attachable_documents.should_not include accountable.document

      # Не должно быть документа, которые помечен на добавление
      attacher.attachable_documents.should_not include new_attachments[0]

      # Должен быть документ, который не помечен на добавление
      attacher.attachable_documents.should include new_attachments[1]

      # Не должно быть документа, который на самом деле приаттачен и не помечен на удаление
      attacher.attachable_documents.should_not include existing_attachments[1]

      # Должен быть документ, который на самом деле приаттачен и помечен на удаление
      attacher.attachable_documents.should include existing_attachments[0]
    end

    xit "provided list shoudn't include draft or prepared docs" do
    end
  end

  context "When getting list of current (temporarily) attached documents" do
  end
end