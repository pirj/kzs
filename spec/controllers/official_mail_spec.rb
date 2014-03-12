require 'spec_helper'

describe Documents::OfficialMailsController do
  let(:user) { FactoryGirl.create(:user) }
  let(:organization) { user.organization }




  describe "GET new" do
    it "has a 200 status code" do
      visit new_documents_official_mail_path
      expect(response.status).to eq(200)
    end
  end

  before(:each) do
    sign_in user
  end
  describe 'open unread mail' do
    let(:mail){
      FactoryGirl.create(:mail_with_direct_recipient)
    }
    let(:inbox_mail){
      inbox_mail = FactoryGirl.build(:mail)
      inbox_mail.recipient_organization = organization
      inbox_mail.save!
      inbox_mail.transition_to!(:prepared)
      inbox_mail.transition_to!(:approved)
      inbox_mail.transition_to!(:sent)
      inbox_mail
    }

    describe('GET mail') do
      it('sould be 200') do
        visit documents_official_mail_path(mail)
        puts response.inspect
        puts documents_official_mail_path(mail)
        response.status.should eq 200
      end
      xit('should mark mail as read for current user'){
        visit documents_official_mail_path(inbox_mail)
        inbox_mail.unread?(user).should be_false
      }
    end

  end
end