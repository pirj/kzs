# coding: utf-8

require 'acceptance/acceptance_helper'

feature "Users create and edit tasks", %q() do

  let(:user) { FactoryGirl.create(:user) }
  let(:task) { FactoryGirl.create(:task) }
  let(:new_path) {  new_tasks_task_path }
  let(:edit_path) {  edit_tasks_task_path(task) }

  describe 'create new task' do
    background do
      visit new_path
      sign_in_with user.email

      expect(current_path).to eq new_path
    end
    context 'valid' do
      scenario 'create new one task' do
        fill_in 'Заголовок', with: 'Тестовая задача'
        fill_in 'Описание', with: 'Тестовая задача'
        select_from_multiple_chosen 'Исполнители'
        select_from_multiple_chosen 'Контрольные лица'
        expect { click_on 'Создать' }.to change(Task, :count).by(1)
      end
    end
  end
end
