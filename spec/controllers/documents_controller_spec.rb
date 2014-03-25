require 'spec_helper'

describe Documents::DocumentsController do
  let(:user) { FactoryGirl.create(:user) }

  before(:each) do
    sign_in user
  end

  describe '#batch' do
    before(:each) do
      request.env["HTTP_REFERER"] = '/back/path'
    end

    describe('should transition from draft to prepared') do
      let(:mail)do
        drafted_mail = FactoryGirl.build(:mail)
        drafted_mail.sender_organization = user.organization
        drafted_mail.recipient_organization = user.organization
        drafted_mail.save!
        drafted_mail.transition_to!(:draft)
        drafted_mail
      end

      it do
        get 'batch', document_ids: [mail.document.id], state: 'prepared'
        response.should redirect_to('/back/path')
      end
    end

    describe('should transition from prepared to approved') do
      let(:mail)do
        prepared_mail = FactoryGirl.build(:mail)
        prepared_mail.sender_organization = user.organization
        prepared_mail.recipient_organization = user.organization
        prepared_mail.approver_id = user.id
        prepared_mail.save!
        prepared_mail.transition_to!(:prepared)
        prepared_mail
      end

      it do
        get 'batch', document_ids: [mail.document.id], state: 'approved'
        response.should redirect_to('/back/path')
      end
    end
  end
end
