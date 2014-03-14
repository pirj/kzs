# coding: utf-8

require 'acceptance/acceptance_helper'

feature "Users review reports", %q{} do

  let(:user) { FactoryGirl.create(:user) }
  let(:organization) { user.organization }
  let!(:users) { 5.times{ create(:user, organization: organization ) } }
  let(:recipient_user) { report.recipient_organization.admin }
  let(:sender_user) { report.sender_organization.admin }
  let!(:report) { FactoryGirl.create(:order) }
  let(:path) {  new_documents_report_path(report) }


  describe 'form fill add fields and save report', js: true do
    let(:path) { new_documents_report_path }
    background do
      visit path
      sign_in_with user.email, 'password'
      # fill auction fields
      fill_in 'Тема', with: 'тест'
      fill_in 'Текст', with: 'тестовый текст'
    end
    scenario 'should create new one report' do
      find('input#is_executor_').click

      find('#documents_report_document_attributes_executor_id_chosen').click
      find('#documents_report_document_attributes_executor_id_chosen .chosen-results li:first-child').click

      #find('#documents_official_mail_document_attributes_approver_id_chosen').click
      #find('#documents_official_mail_document_attributes_approver_id_chosen .chosen-results li:first-child').click

      find('#documents_report_document_attributes_approver_id_chosen').click
      find('#documents_report_document_attributes_approver_id_chosen .chosen-results li:first-child').click
      expect { click_button 'подготовить' }.to change(Documents::Report, :count).by(1)
      expect(page).to have_content 'не может быть пустым'
      expect(current_path).to_not eq(new_documents_report_path)
    end

    scenario 'should not create new report' do
      expect { click_button 'подготовить' }.to_not change(Documents::Report, :count)
      expect(current_path).to_not eq(new_documents_report_path)
      expect(page).to have_content 'не может быть пустым'
      save_and_open_page
    end
  end
end