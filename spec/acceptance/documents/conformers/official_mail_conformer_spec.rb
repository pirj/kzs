require 'acceptance/acceptance_helper'

feature "Users view agreement-conformer buttons", %q() do
  let(:accountable) { FactoryGirl.create(:mail_with_direct_recipient_and_conformers) }
  let(:approver) { accountable.approver }
  # let(:recipient_user) { accountable.recipient_organization.admin }
  # let(:sender_user) { accountable.sender_organization.admin }
  let(:path) {  polymorphic_path(accountable) }


  #subject { page }



  describe 'user can not use someone else`s agreement ', js: true do

    background do
      visit path
      sign_in_with accountable.conformers.first.email, 'password'
    end



    context 'creator' do
      let(:user) { accountable.creator }



      it 'should use own agreement-button' do
        # проверяем что кнопка юзера нажимается

          expect(page).to have_selector('.js-document-conform-agree-btn')
          expect(all('.js-document-conform-agree-btn').count).to eq(1)

      end
    end


  end

  

  describe 'user can not vote again ' , js: true do
    background do
      visit path
      sign_in_with accountable.conformers.first.email, 'password'
    end

    context 'creator' do


      let(:user) { accountable.creator }


      it 'no button after vote' do
        #голосуем, проверяем что кнопку больше не нажать
        skip_welcome
        within('.conformers-list') do

          page.execute_script("$('.js-document-conform-agree-btn')[0].click()")

        end
        sleep(1)

        fill_in 'conformation_comment', :with => "10"

        first('.spec-submit-comment').click
        sleep(1)

        within('.conformers-list') do

          page.execute_script("$('.js-document-conform-agree-btn')[0].click()")

        end

        #expect(all('.js-document-conform-txt:visible').count).to eq(0)
        expect(page).to have_selector('.js-document-conform-txt', visible: false)
      end
    end
  end

  #describe 'user must create comment if agreement negative' do  #2
  #  it 'negative vote without comment should not be created' do
  #    #пытаеся сделать подтверждение с пустым окном комментария
  #
  #  end
  #
  #  it 'negative vote with comment should be created' do
  #    #должно пройти
  #  end
  #
  #end


end
