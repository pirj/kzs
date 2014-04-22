# coding: utf-8

require 'acceptance/acceptance_helper'

feature "User review mail", %q() do

  let!(:mail) { FactoryGirl.create(:mail) }
  let(:sender_user) { mail.approver }
  let(:recipient_user) { FactoryGirl.create(:user, organization: mail.recipient_organization) }
  let(:admin) { mail.recipient_organization.admin }
  let(:director) { mail.recipient_organization.director }
  let(:path) {  documents_official_mail_path(mail) }

  describe 'reply action' do
    context 'sender' do
      background do
        mail.transition_to!(:draft)
        mail.transition_to!(:prepared)
        mail.transition_to!(:approved)
        mail.transition_to!(:sent)
        visit path
        sign_in_with sender_user.email, 'password'
      end

      scenario 'not check reply action' do
        expect(page).to_not have_content('Ответить')
      end
    end

    context 'recipient' do
      background do
        mail.transition_to!(:draft)
        mail.transition_to!(:prepared)
        mail.transition_to!(:approved)
        mail.transition_to!(:sent)
        visit path
        sign_in_with user.email, 'password'
      end

      [:recipient_user, :admin, :director].each do |_user|
        context _user do
          let(:user) { send(_user) }
          scenario 'check reply action' do
            expect(page).to have_selector('a', 'Ответить')
          end
        end
      end

    end
  end
end
