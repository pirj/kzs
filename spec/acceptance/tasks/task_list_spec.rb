# coding: utf-8

require 'acceptance/acceptance_helper'

feature "Users can create and views tasks in list", %q() do

  # создаем заранее несколько пользователей,
  # чтобы выбрать их как исполнителей или контрольных лиц при создании задачи
  let!(:user) { FactoryGirl.create(:user_with_organization) }
  let!(:user_1) { FactoryGirl.create(:user, organization: user.organization) }
  let!(:user_2) { FactoryGirl.create(:user, organization: user.organization) }

  let(:task) { FactoryGirl.create(:tasks_task) }
  let(:new_path) {  new_task_path }
  let(:edit_path) { edit_task_path(task) }
  let(:list_path) { tasks_path }


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
end
