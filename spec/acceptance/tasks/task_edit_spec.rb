# coding: utf-8

require 'acceptance/acceptance_helper'

feature "Users create and edit tasks", %q() do

  # создаем заранее несколько пользователей,
  # чтобы выбрать их как исполнителей или контрольных лиц при создании задачи
  let!(:user) { FactoryGirl.create(:user) }
  let!(:user_1) { FactoryGirl.create(:user, organization: user.organization) }
  let!(:user_2) { FactoryGirl.create(:user, organization: user.organization) }

  let(:task) { FactoryGirl.create(:task) }
  let(:new_path) {  new_tasks_task_path }
  let(:edit_path) {  edit_tasks_task_path(task) }

  background do
    visit root_path
    sign_in_with user.email
    skip_welcome
  end

  describe 'create new task', js: true do
    background do
      visit new_path
      expect(current_path).to eq new_path
    end

    context 'valid' do
      scenario 'create new one task' do
        fill_in 'Заголовок', with: 'Тестовая задача'
        fill_in 'Описание', with: 'Тестовая задача'
        fill_in 'Дата начала', with: Date.today
        fill_in 'Дата окончания', with: Date.today + 2.days
        select_from_multiple_chosen 'Исполнители'
        select_from_multiple_chosen 'Контрольные лица'

        expect { click_on 'Создать' }.to change(Tasks::Task, :count).by(1)
        task = Tasks::Task.last
        expect(current_path).to eq tasks_task_path(task)
        expect(page).to have_selector('h1', task.title)
      end
    end
  end

  describe 'edit existed task', js: true do
    background do
      visit edit_path
      expect(current_path).to eq edit_path
    end
    
    context 'success editing' do
      scenario 'update task title' do
        new_title = 'Новая тестовая задача'
        fill_in 'Заголовок', with: new_title

        expect { click_on 'Сохранить' }.to_not change(Tasks::Task, :count)
        expect(current_path).to eq tasks_task_path(task)
        expect(page).to have_selector('h1', new_title)
      end
    end

    context 'fail editing' do
      scenario 'start date earlier than today' do
        fill_in 'Дата начала', with: Date.today - 1.day

        expect { click_on 'Сохранить' }.to_not change(Tasks::Task, :count)
        expect(page).to have_content 'ошибка при сохранении'
      end
    end
  end

end
