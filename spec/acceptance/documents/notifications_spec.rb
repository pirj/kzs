# coding: utf-8

require 'acceptance/acceptance_helper'

feature "User receives documents notifications", %q() do

  let!(:mail) { FactoryGirl.create(:mail_with_direct_recipient_and_conformers) }

  let(:unreadable_path) { documents_path(with_type: 'incoming') }
  let(:edit_path) { edit_polymorphic_path(mail) }

  let(:approver)  { mail.approver }
  let(:creator)  { mail.creator }
  let(:executor)  { mail.executor }
  let(:conformer) { mail.conformers.first }

  # describe 'notifications without changes in documents' do
  #   context 'without notifiable documents' do
  #     let(:user){ mail.sender_organization.director }
  #
  #     background do
  #       visit unreadable_path
  #       sign_in_with user.email
  #       visit unreadable_path
  #       expect(current_url).to eq documents_url(with_type: 'incoming')
  #     end
  #
  #
  #     context 'without changing and notifications' do
  #       [:executor, :creator, :approver, :conformer].each do |_user|
  #         context _user do
  #           let(:user) { send(_user) }
  #
  #           scenario 'empty notifications badges' do
  #             expect(page).to_not have_css '.spec-notification-badge'
  #           end
  #
  #           scenario 'empty document list' do
  #             expect(page).to have_content 'по заданным параметрам фильтрации документов нет'
  #           end
  #
  #         end
  #       end
  #     end
  #
  #   end
  # end

  # describe 'notifications after saving document' do
  #   context 'saving document without changes' do
  #     # оповещения создаются по-настоящему в контроллерах, никаких колбеков в моделях
  #     # поэтому нужно зайти под главным и протолкнуть письмо далее по цепочке статусов
  #     background do
  #       sign_out
  #       visit edit_path
  #       sign_in_with approver.email
  #       expect(current_path).to eq edit_path
  #       click_on 'Сохранить'
  #
  #       sign_out
  #       sign_in_with user.email
  #       visit unreadable_path
  #     end
  #
  #     [:executor, :conformer].each do |_user|
  #       context _user do
  #         let(:user) { send(_user) }
  #
  #         scenario 'not empty document list' do
  #           expect(page).to_not have_content 'по заданным параметрам фильтрации документов нет'
  #           expect(page).to have_content mail.title
  #         end
  #
  #         scenario 'badge about one notification documents count' do
  #           page.all('.spec-notification-badge').each do |elem|
  #             expect(elem).to have_content '1'
  #           end
  #         end
  #
  #       end
  #     end
  #
  #     # у aprrover другое условие, потому что он является последним,
  #     # кто внес редакции в документ, он «как-бы в курсе» изменений документа
  #     # поэтому у него и отдельный сценарий
  #     context 'approver' do
  #       let(:user) { approver }
  #
  #       scenario 'not empty document list' do
  #         expect(page).to_not have_content 'по заданным параметрам фильтрации документов нет'
  #         expect(page).to have_content mail.title
  #       end
  #
  #       scenario 'empty notification badge' do
  #         expect(page).to_not have_css '.spec-notification-badge'
  #       end
  #
  #     end
  #   end
  # end

  describe 'notifications after editing document', js: true do
    context 'old interested people' do
      context 'edit by approver' do
        background do
          # выделяем текущих интересантов

          # используем принудительное копирование через dup, чтобы записать в переменную значение,а не ссылку.
          # иначе дальше по коду вызов этой переменной приводит к запросу conformers у измененного mail.
          old_conformers = mail.conformers.dup

          old_creator = mail.creator
          old_executor = mail.executor
          old_approver = mail.approver
          expect(approver).to_not eq creator

          # проходим на страницу для редактирования
          visit edit_path
          sign_in_with approver.email
          expect(current_path).to eq edit_path
          skip_welcome

          # изменяем список контрольных лиц
          remove_from_multiple_chosen id: 'documents_official_mail_document_attributes_conformer_ids'
          select_from_multiple_chosen id: 'documents_official_mail_document_attributes_conformer_ids', count: 1

          # изменяем исполнителя и контрольное лицо
          select_from_chosen 'Исполнитель'
          select_from_chosen 'Контрольное лицо'

          click_on 'Сохранить'

          # убеждаемся, что обновили данные
          mail.reload
          mail.conformers.reload
          expect(mail.creator).to_not eq old_creator
          expect(mail.approver).to_not eq old_approver
          expect(mail.executor).to_not eq old_executor
          expect(mail.conformers).to_not eq old_conformers

          # подготавливаемся ко входу по каждым отдельным пользователем
          sign_out
          visit unreadable_path
          sign_in_with user.email
        end

        context 'approver became as creator' do
          [:approver, :conformer, :executor].each do |_user|
              context _user do
                let(:user) { send(_user) }

                scenario 'not empty document list' do
                  expect(page).to_not have_content 'по заданным параметрам фильтрации документов нет'
                  expect(page).to have_content mail.title
                end

                scenario 'badge about one notification documents count' do
                  page.all('.spec-notification-badge').each do |elem|
                    expect(elem).to have_content '1'
                  end
                end

              end
            end

          # у creator другое условие, потому что он является последним,
          # кто внес редакции в документ, он «как-бы в курсе» изменений документа
          # поэтому у него и отдельный сценарий
          context 'creator' do
            let(:user) { creator }

            scenario 'not empty document list' do
              expect(page).to_not have_content 'по заданным параметрам фильтрации документов нет'
              expect(page).to have_content mail.title
            end

            scenario 'empty notification badge' do
              expect(page).to_not have_css '.spec-notification-badge'
            end

          end
        end
      end
    end
    context 'new interested people'
  end

  describe 'notifications after conformating document'
  describe 'notifications after create replying mail'

end
