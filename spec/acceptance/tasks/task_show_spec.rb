# coding: utf-8

require 'acceptance/acceptance_helper'

feature "Users see show-page task", %q() do

  # создаем заранее несколько пользователей,
  # чтобы выбрать их как исполнителей или контрольных лиц при создании задачи
  let(:task) { FactoryGirl.create(:tasks_task) }
  let(:show_path) {  task_path(task) }

  let!(:user) { task.inspector }
  let!(:user_1) { FactoryGirl.create(:user, organization: user.organization) }
  let!(:user_2) { FactoryGirl.create(:user, organization: user.organization) }

  background do
    visit root_path
    sign_in_with user.email
    skip_welcome
  end

  describe 'create new task and show', js: true do
    background do
      visit task_path(task)
    end

    context 'show fill args' do
      scenario 'show args' do
        expect(page).to have_content 'Инспектор'
        expect(page).to have_content 'Исполнитель'
        expect(page).to have_content 'Дата начала'
        expect(page).to have_content 'Дата окончания'
        expect(page).to have_content 'Описание'
      end
    end
  end


  describe 'drag and drop task', js: true do
    background do
      visit task_path(task)
    end

    scenario 'drag task' do
    end

  end

end
