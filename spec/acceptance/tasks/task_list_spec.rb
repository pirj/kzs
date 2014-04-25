# coding: utf-8

require 'acceptance/acceptance_helper'

feature "Users can create and views tasks in list", %q() do

  # создаем заранее несколько пользователей,
  # чтобы выбрать их как исполнителей или контрольных лиц при создании задачи
  let!(:user) { FactoryGirl.create(:user) }
  let!(:user_1) { FactoryGirl.create(:user, organization: user.organization) }
  let!(:user_2) { FactoryGirl.create(:user, organization: user.organization) }

  let(:task) { FactoryGirl.create(:task) }
  let(:new_path) {  new_tasks_task_path }
  let(:edit_path) {  edit_tasks_task_path(task) }
  let(:list_path) {tasks_tasks_path}


  background do
    visit root_path
    sign_in_with user.email
    skip_welcome
  end

  describe 'page must have button', js: true do
    background do
      visit list_path
    end
    scenario do

      expect(page).to have_content('Создать новую задачу')
    end
  end

  describe 'user can create tasks and views their in list', js: true do
    background do
      visit list_path
    end

    scenario do

      first('.spec-new_task').click
      expect(current_path).to eq new_path
      fill_in 'Заголовок', with: 'Тестовая задача'
      fill_in 'Описание', with: 'Тестовая задача'
      fill_in 'Дата начала', with: Date.today
      fill_in 'Дата окончания', with: Date.today + 2.days
      select_from_multiple_chosen 'Исполнители'
      select_from_multiple_chosen 'Контрольные лица'

      expect { click_on 'Создать' }.to change(Tasks::Task, :count).by(1)
      task = Tasks::Task.last
      visit list_path
      expect(page).to have_selector('h1', task.title)
    end


  end



end
