require 'acceptance/acceptance_helper'

feature "Users review order", %q{} do

  let!(:user) { FactoryGirl.create(:user) }
  let!(:order) { FactoryGirl.create(:order) }
  let(:path) { root_path }

  describe 'not authenticate for unregisterable user' do
    it 'should not authennticate with unregistarable user' do
      visit path

      sign_in_with user.email, 'password'

      expect(current_path).to eq(path)
    end
  end


end