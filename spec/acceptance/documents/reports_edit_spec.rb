# coding: utf-8

require 'acceptance/acceptance_helper'

feature "Users create reports", %q() do

  let(:user) { order.recipient_organization.admin }
  let!(:order) { FactoryGirl.create(:order) }
  let(:path) {  new_documents_report_path(report) }

  describe 'form fill add fields and save report', js: true do
    let(:path) { new_documents_report_path }

    background do
      visit path

      order.transition_to!(:draft)
      order.transition_to!(:prepared)
      order.transition_to!(:approved)
      order.transition_to!(:sent)

      sign_in_with user.email, 'password'
      # fill auction fields
      fill_in 'Тема', with: 'тест'
      fill_in 'Текст', with: 'тестовый текст'
    end


    scenario 'should create new one report' do

      select_from_chosen label = 'Предписание'
      select_from_chosen label = 'Контрольное лицо'

      expect { click_button 'Подготовить' }.to change(Documents::Report, :count).by(1)
      expect(page).to_not have_content 'не может быть пустым'
      expect(current_path).to_not eq(new_documents_report_path)
    end


    scenario 'should not create new report' do
      skip_welcome
      expect { click_button 'Подготовить' }.to_not change(Documents::Report, :count)
      expect(current_path).to_not eq(new_documents_report_path)
      expect(page).to have_content 'не может быть пустым'
    end
  end
end
