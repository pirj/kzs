#require 'acceptance/acceptance_helper'
#
#feature "User views user bar", %q() do
#
#  let(:user) { FactoryGirl.create(:user) }
#  let(:path) { root_path }
#  let(:documents_path) { documents_path }
#  let(:permits_path) { permits_path }
#  let(:organizations_path) { organizations_path }
#
#
#
#
#  describe 'user-bar button is available', js: true do
#
#    background do
#      visit path
#      sign_in_with user.email, 'password'
#    end
#
#    context 'permits page' do
#      it 'must see button' do
#        skip_welcome
#        visit permits_path
#        skip_welcome
#        expect(all('.spec-user-bar').count).to eq(1)
#      end
#    end
#
#    #context 'documents page' do
#    #  it 'must see button' do
#    #    visit documents_path
#    #    expect(all('.spec-user-bar').count).to eq(1)
#    #  end
#    #end
#    #
#    #context 'organizations page' do
#    #  it 'must see button' do
#    #    visit organizations_path
#    #    expect(all('.spec-user-bar').count).to eq(1)
#    #  end
#    #end
#    #
#    #context 'dashboard page' do
#    #  it 'button not available' do
#    #    visit path
#    #    expect(all('.spec-user-bar').count).to eq(0)
#    #  end
#    #end
#
#
#  end
#
#
#end
