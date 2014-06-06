require 'acceptance/acceptance_helper'

feature "User views user bar", %q() do

  let(:user) { FactoryGirl.create(:user_with_organization) }
  let(:path) { root_path }

  describe 'user-bar button is available', js: true do

    background do
      visit path
      sign_in_with user.email, 'password'
    end

    context 'permits page' do
      it 'must see button' do
        visit permits_path

        expect(all('.spec-user-bar').count).to eq(1)
      end
    end

    context 'documents page' do
      it 'must see button' do
        visit documents_documents_path
        expect(all('.spec-user-bar').count).to eq(1)
      end
    end

    context 'organizations page' do
      it 'must see button' do
        visit organizations_path
        expect(all('.spec-user-bar').count).to eq(1)
      end
    end

    context 'dashboard page' do
      it 'button not available' do
        expect(all('.spec-user-bar').count).to eq(0)
      end
    end

  end


  describe 'user-bar unclose and closed', js: true do
    background do
      visit documents_documents_path
      sign_in_with user.email, 'password'
      skip_welcome
    end

    it 'bar opened' do
      within('.spec-user-bar') do
        first(' .js-popover').click

        expect(all('._user-bar', visible: true).count).to eq(1)
      end

    end

    #page.should have_selector('#blah', visible: true)

    it 'bar closed' do
      within('.spec-user-bar') do
        first(' .js-popover').click
        first(' .js-popover-close').click

        expect(page).to have_selector('._user-bar', visible: false)
        create_screenshot
      end
    end
  end
end
