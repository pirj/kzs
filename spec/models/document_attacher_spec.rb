require 'spec_helper'

describe DocumentAttacher do
  before :all do
    @session = {}
  end

  it "shoud be able to clear the state" do
    accountable = FactoryGirl.create(:mail_with_attachment)
    existing_attachment = accountable.attached_documents.first
    attachment = FactoryGirl.create(:mail_approved)

    attacher = DocumentAttacher.new(accountable, @session)

    attached_documents = attacher.attached_documents
    attachable_documents = attacher.attachable_documents
    
    attacher.detach existing_attachment
    attacher.attach attachment

    attacher.clear

    attacher.attached_documents.should == attached_documents
    attacher.attachable_documents.should == attachable_documents
  end

  context "on initialize" do
    it "should accept document/accountable and a session on initialize" do
      mail = FactoryGirl.create(:mail_with_direct_recipient)
      expect {attacher = DocumentAttacher.new(mail, {})}.not_to raise_error
    end

    it "should raise ArgumentError if document sent is not a document/accountable" do
      expect {attacher = DocumentAttacher.new(1, {})}.to raise_error ArgumentError
    end
  end

  context "When pre-attaching a document" do
    it "should be able to pre-attach approved document" do
      attachment = FactoryGirl.create(:mail_approved)
      accountable = FactoryGirl.create(:mail_with_direct_recipient)
      attacher = DocumentAttacher.new(accountable, @session)
      attacher.attach attachment

      attacher.attached_documents.should include attachment.document
    end

    it "should not repeat attached document when attached single document several times" do
      attachment = FactoryGirl.create(:mail_approved).document
      accountable = FactoryGirl.create(:mail_with_direct_recipient)
      attacher = DocumentAttacher.new(accountable, @session)
      3.times {attacher.attach attachment}

      attacher.attached_documents.should include attachment
      attacher.attached_documents.count(attachment).should == 1

    end

    it "should raise exception when document being attached by ID doesn't exists" do
      attachment = FactoryGirl.create(:mail_approved)
      accountable = FactoryGirl.create(:mail_with_direct_recipient)
      
      attachment_document_id = attachment.document.id
      Document.destroy(attachment_document_id)

      attacher = DocumentAttacher.new(accountable, @session)

      expect {attacher.attach attachment_document_id}.to raise_error
    end

    it "should raise exception if trying to attach draft" do
      attachment = FactoryGirl.create(:mail_with_direct_recipient)
      accountable = FactoryGirl.create(:mail_with_direct_recipient)

      attacher = DocumentAttacher.new(accountable, @session)

      expect { attacher.attach attachment }.to raise_error
    end
  end

  context "When pre-detaching a document" do
    it "should be able to pre-detach a document, if this is real attached document" do
      accountable = FactoryGirl.create(:mail_with_attachment)
      attachment = accountable.attached_documents.first
      
      attacher = DocumentAttacher.new(accountable, @session)
      attacher.detach attachment

      attacher.attached_documents.should_not include attachment
    end

    it "should raise exception when document being detached by ID doesn't exist" do
      accountable = FactoryGirl.create(:mail_with_attachment)

      attachment = accountable.attached_documents.first
      attachment_id = attachment.id
      
      attacher = DocumentAttacher.new(accountable, @session)

      attachment.destroy

      expect {attacher.detach attachment_id}.to raise_error
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

    it "should raise exception if any document can't be attached" do
      attachment = FactoryGirl.create(:mail_approved)
      attachment2 = FactoryGirl.create(:mail_approved)
      accountable = FactoryGirl.create(:mail_with_direct_recipient)
      
      attacher = DocumentAttacher.new(accountable, @session)

      attacher.attach attachment
      attacher.attach attachment2

      Document.destroy(attachment.document.id)

      expect {attacher.confirm}.to raise_error
    end

    it "should raise exception if any document can't be detached" do
      accountable = FactoryGirl.create(:mail_with_two_attachments)

      existing_attachments = [
        accountable.attached_documents.first,
        accountable.attached_documents.last
      ]
      
      attacher = DocumentAttacher.new(accountable, @session)

      attacher.detach existing_attachments[0]
      attacher.detach existing_attachments[1]

      Document.destroy(existing_attachments[0].id)

      expect {attacher.confirm}.to raise_error
    end
  end

  context "When getting list" do
    before :each do
      @accountable = FactoryGirl.create(:mail_with_two_attachments)
      
      existing_attachments = [
        @accountable.attached_documents.first,
        @accountable.attached_documents.last
      ]
      
      new_attachments = [
        FactoryGirl.create(:mail_approved).document,
        FactoryGirl.create(:mail_approved).document
      ]

      draft = FactoryGirl.create(:mail_with_direct_recipient)
      
      @attacher = DocumentAttacher.new(@accountable, @session)
      @attacher.detach existing_attachments[0]
      @attacher.attach new_attachments[0]
    end

    context "of currently attachable documents (in the middle of attach process)" do
      it "provided list should not contain the document itself" do
        @attacher.attachable_documents.should_not include @accountable.document
      end

      it "provided list should not contain any of (temporarily) attached docs" do
        @attacher.attached_documents.each do |doc|
          @attacher.attachable_documents.should_not include doc
        end
      end

      it "provided list shouldn't include draft docs" do
        @attacher.attachable_documents.each {|doc| doc.state.should_not == 'draft'}
      end

      xit "provided list should include only docs, visible to the current user" do
      end
    end

    context "of current attached documents (in the middle of attach process)" do
    
      it "provided list should not containt document itself" do
        @attacher.attached_documents.should_not include @accountable.document
      end

      it "provided list should not contain any of (temporarily) attachable docs" do
        @attacher.attachable_documents.each do |doc|
          @attacher.attached_documents.should_not include doc
        end
      end

      xit "provided list should include only docs, visible to the current user" do
      end

    end
  end
  
end