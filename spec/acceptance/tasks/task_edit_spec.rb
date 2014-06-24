# coding: utf-8

require 'acceptance/acceptance_helper'

feature "Users create and edit tasks", %q() do

  # создаем заранее несколько пользователей,
  # чтобы выбрать их как исполнителей или контрольных лиц при создании задачи
  let!(:tasks_task) { FactoryGirl.create(:tasks_task) }
  let!(:user) { tasks_task.inspector }
  let!(:user_1) { FactoryGirl.create(:user, organization: user.organization) }
  let!(:user_2) { FactoryGirl.create(:user, organization: user.organization) }


  let(:new_path) {  new_task_path }
  let(:edit_path) {  edit_task_path(tasks_task) }

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
      pending 'create new one task' do
        title = 'Тестовая задача'
        fill_in 'Заголовок', with: title
        fill_in 'Описание', with: 'Описание тестовой задачи'
        fill_in 'Дата начала', with: Date.today
        fill_in 'Дата окончания', with: Date.today + 2.days
        select_from_chosen 'Исполнитель'
        select_from_chosen 'Инспектор'

        expect { click_on 'Создать' }.to change(Tasks::Task, :count).by(1)
        _task = Tasks::Task.where(title: title).first
        expect(current_path).to eq task_path(_task)
        expect(page).to have_selector('h1', _task.title)
      end
    end
  end

  describe 'edit existed task', js: true do
    background do
      visit edit_path
      expect(current_path).to eq edit_path
      create_screenshot
    end
    
    context 'success editing' do
      scenario 'update task title' do
        new_title = 'Новая тестовая задача'
        fill_in 'Заголовок', with: new_title

        expect { click_on 'Сохранить' }.to_not change(Tasks::Task, :count)
        expect(current_path).to eq task_path(tasks_task)
        expect(page).to have_selector('h1', new_title)
      end
    end

    context 'fail editing' do
      pending 'start date earlier than today' do
        fill_in 'Дата начала', with: Date.today - 5.days
        create_screenshot
        expect { click_on 'Сохранить' }.to_not change(Tasks::Task, :count)
        create_screenshot
        expect(page).to have_content 'должно быть не ранее'
      end
    end
  end

end
