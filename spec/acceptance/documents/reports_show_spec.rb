# coding: utf-8

require 'acceptance/acceptance_helper'

feature "Users review reports", %q{} do

  let(:user) { FactoryGirl.create(:user) }
  let(:recipient_user) { report.recipient_organization.admin }
  let(:sender_user) { report.sender_organization.admin }
  let!(:report) { FactoryGirl.create(:order) }
  let(:path) {  new_documents_report_path(report) }


  describe 'form fill add fields and save report' do
    let(:path) { new_documents_report_path }
    background do
      visit path
      sign_in_with user.email, 'password'
      # fill auction fields
      fill_in 'Тема', with: 'тест'
      fill_in 'Текст', with: 'тестовый текст'
    end
    scenario 'should create new one report' do
      expect { click_button 'Подготовить' }.to change(Documents::Report, :count).by(1)
      expect(page).to have_content 'не может быть пустым'
      expect(current_path).to_not eq(new_documents_report_path)
    end

    scenario 'should not create new report' do
      expect { click_button 'Подготовить' }.to_not change(Documents::Report, :count)
      expect(current_path).to_not eq(new_documents_report_path)
      expect(page).to have_content 'не может быть пустым'
      save_and_open_page
    end
  end
end