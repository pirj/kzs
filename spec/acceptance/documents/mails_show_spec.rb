# coding: utf-8

require 'acceptance/acceptance_helper'

feature "User review mail", %q{} do

  let!(:mail) { FactoryGirl.create(:mail_with_direct_recipient) }
  let(:sender_user) { mail.sender_organization.admin }
  let(:recipient_user) { mail.recipient_organization.admin }
  let(:path) {  documents_official_mail_path(mail) }

  describe 'reply action' do
    context 'sender' do
      background do
        visit path
        sign_in_with sender_user.email, 'password'
        visit path
        mail.transition_to!(:draft)
        mail.transition_to!(:prepared)
        mail.transition_to!(:approved)
        mail.transition_to!(:sent)
      end

      scenario 'not check reply action' do
        expect(page).to_not have_content('Ответить')
      end
    end

    context 'recipient' do
      background do
        visit path
        sign_in_with recipient_user.email, 'password'
        visit path
        mail.transition_to!(:draft)
        mail.transition_to!(:prepared)
        mail.transition_to!(:approved)
        mail.transition_to!(:sent)
      end

      scenario 'check reply action' do
        expect(page).to have_content('Ответить')
      end
    end
  end
end