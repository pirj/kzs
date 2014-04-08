require 'acceptance/acceptance_helper'

feature "Users view states for Order", %q() do
  let(:document) { FactoryGirl.create(:order) }
  let(:user) { FactoryGirl.create(:user) }
  let(:recipient_user) { document.recipient_organization.admin }
  let(:sender_user) { document.sender_organization.admin }
  let(:path) {  documents_order_path(document) }

  background do
    visit path
    sign_in_with sender_user.email, 'password'
  end


  describe 'user can not use someone else`s agreement ' do #4

    it 'should use own agreement-button' do
      # проверяем что кнопка юзера нажимается
    end
    it 'shouldn`t use foreign agreement-button' do
      # проверяем что чужие кнопки заблокированы
    end

  end

  describe 'user can not vote again ' do  #1

    it 'no button after vote' do
      #голосуем, проверяем что кнопку больше не нажать
    end

  end

  describe 'user must create comment if agreement negative' do  #2
    it 'negative vote without comment should not be created' do
      #пытаеся сделать подтверждение с пустым окном комментария

    end

    it 'negative vote with comment should be created' do
      #должно пройти
    end

  end


end
