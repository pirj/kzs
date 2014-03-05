require 'acceptance/acceptance_helper'

feature "Users may authenitacting", %q{} do

  let(:path) { root_path }

  describe 'not authenticate for unregistered user' do
    pending 'disable authennticate for unregistarable user'
  end


  describe 'authenticate for registered user' do
    pending 'allow authennticate for registared user'
  end
end