# coding: utf-8

require 'acceptance/acceptance_helper'

feature "Users review mails", %q() do

  let(:user) { mail.creator }
  let(:organization) { user.organization }
  let!(:users) { 5.times.map { create(:user, organization: organization) } }
  let(:recipient_user) { mail.recipient_organization.admin }
  let(:sender_user) { mail.sender_organization.admin }
  let!(:mail) { FactoryGirl.create(:mail_with_many_recipients) }
  let(:path) {  new_documents_official_mail_path }

  describe 'form fill add fields and save mail', js: true do
    let(:path) { new_documents_official_mail_path }

    background do
      visit path
      sign_in_with user.email, 'password'
      # fill auction fields
      fill_in 'Тема', with: 'тест'
      fill_in 'Текст', with: 'тестовый текст'
    end

    scenario 'should create new one mail' do
      select_from_chosen label = 'Контрольное лицо'
      select_from_multiple_chosen label: 'Получатели'
      expect { click_button 'Подготовить' }.to change(Documents::OfficialMail, :count).by(1)
      expect(page).to_not have_content 'не может быть пустым'
      expect(page).to_not have_content 'Выберите хотябы одного адресата'
      expect(current_path).to_not eq(new_documents_official_mail_path)
    end

    scenario 'should not create new mail' do
      skip_welcome
      expect { click_button 'Подготовить' }.to_not change(Documents::OfficialMail, :count)
      expect(current_path).to_not eq(new_documents_official_mail_path)
      expect(page).to have_content 'Выберите хотябы одного адресата'
    end

  end
end
