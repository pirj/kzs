require 'acceptance/acceptance_helper'

feature "Users view agreement-conformer buttons", %q() do
  let(:accountable) { FactoryGirl.create(:mail_with_direct_recipient_and_conformers) }
  let(:approver) { accountable.approver }
  let(:path) {  polymorphic_path(accountable) }

  describe 'user can not use someone else`s agreement ', js: true do

    background do
      visit path
      sign_in_with accountable.conformers.first.email, 'password'
    end
      it 'should use own agreement-button' do
        # проверяем что кнопка юзера нажимается

          expect(page).to have_selector('.js-document-conform-agree-btn')
          expect(all('.js-document-conform-agree-btn').count).to eq(1)
      end
  end

  

  describe 'user can not vote again ' , js: true do
    background do
      visit path
      sign_in_with accountable.conformers.first.email, 'password'
    end

      scenario 'no button after vote' do
        #голосуем, проверяем что кнопку больше не нажать
        skip_welcome
        within('.conformers-list') do
          page.execute_script("$('.js-document-conform-agree-btn')[0].click()")
        end
        sleep(1)
        fill_in 'conformation_comment', :with => "10"
        first('.spec-submit-comment').click
        sleep(1)
        expect(page).to have_selector('.js-document-conform-txt', visible: false)
      end

  end

  context 'negative vote' do
    describe 'user must create required comment', js:true do
      background do
        visit path
        sign_in_with accountable.conformers.first.email, 'password'
        skip_welcome
        within('.conformers-list') do
          page.execute_script("$('.js-document-conform-deny-btn')[0].click()")       #сдвинули ползунок
        end
        sleep(1)
      end

      scenario 'disabling to send empty comment' do
        expect(page).to have_xpath("//input[contains(@class,'spec-submit-comment') and @disabled]")
      end


      scenario 'disabling to send fill-and-empty comment' do
        fill_in 'conformation_comment', :with => 'exampletext'
        sleep(1)
        expect(page).to_not have_xpath("//input[contains(@class,'spec-submit-comment') and @disabled]")
        fill_in 'conformation_comment', :with => ''
        sleep(1)
        first('.spec-submit-comment').click                               #жмем кнопку отправить комментарий
        expect(page).to have_selector('.js-document-conform-txt', visible: true)
      end

      scenario 'displaying sent comment' do
        expect(page).to_not have_content 'exampletext'

        fill_in 'conformation_comment', :with => 'exampletext'
        sleep(1)
        first('.spec-submit-comment').click                               #жмем кнопку отправить комментарий

        expect(page).to have_selector('.js-document-conform-txt', visible: false)
        expect(page).to have_content 'Комментарии'
        expect(page).to have_content 'exampletext'
      end
    end
  end


end
