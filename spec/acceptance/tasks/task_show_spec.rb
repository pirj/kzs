# coding: utf-8

require 'acceptance/acceptance_helper'

feature "Users see show-page task", %q() do

  # создаем заранее несколько пользователей,
  # чтобы выбрать их как исполнителей или контрольных лиц при создании задачи
  let!(:user) { FactoryGirl.create(:user) }
  let!(:user_1) { FactoryGirl.create(:user, organization: user.organization) }
  let!(:user_2) { FactoryGirl.create(:user, organization: user.organization) }

  let(:task) { FactoryGirl.create(:task) }
  let(:show_path) {  tasks_path(task) }

  background do
    visit root_path
    sign_in_with user.email
    skip_welcome
  end

  describe 'create new task and show', js: true do
    background do
      visit tasks_path(task)
    end

    context 'show fill args' do
      scenario 'show args' do
        fill_in 'Контрольные лица'
        fill_in 'Исполнители'
        fill_in 'Дата начала'
        fill_in 'Дата окончания '
        fill_in 'Описание '
      end
    end
  end

end
