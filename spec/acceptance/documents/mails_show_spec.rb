# coding: utf-8

require 'acceptance/acceptance_helper'

feature "Users review mails", %q{} do

  let(:user) { FactoryGirl.create(:user) }
  let(:recipient_user) { mail.recipient_organization.admin }
  let(:sender_user) { mail.sender_organization.admin }
  let!(:mail) { FactoryGirl.create(:order) }
  let(:path) {  new_documents_official_mail_path(mail) }


  describe 'form fill add fields and save mail' do
    let(:path) { new_documents_official_mail_path }
    background do
      visit path
      sign_in_with user.email, 'password'
      # fill auction fields
      fill_in 'Тема', with: 'тест'
      fill_in 'Текст', with: 'тестовый текст'
    end
    scenario 'should create new one mail' do
      expect { click_button 'Подготовить' }.to change(Documents::OfficialMail, :count).by(1)
      expect(page).to have_content 'не может быть пустым'
      expect(current_path).to_not eq(new_documents_official_mail_path)
    end

    scenario 'should not create new mail' do
        expect { click_button 'Подготовить' }.to_not change(Documents::OfficialMail, :count)
        expect(current_path).to_not eq(new_documents_official_mail_path)
        expect(page).to have_content 'не может быть пустым'
        save_and_open_page
      end
  end
end