require 'spec_helper'

describe OrganizationsController do
  def valid_attributes
    { organization: {
        title: Faker::Lorem.sentence,
      }
    }
  end
  let!(:user) { User.make! }
  before :each do
    sign_in user
  end

  describe 'GET index' do
    let!(:organization) { Organization.make! }
    it 'assigns all Organization' do
      get :index
      assigns(:organizations).should eq([organization])
    end
  end

  describe 'POST create' do
    it 'new object Organization' do
      expect {
        post :create, valid_attributes
      }.to change(Organization, :count).by(1)
    end
    it 'redirect' do
      post :create, valid_attributes
      response.should redirect_to(edit_organization_path(Organization.last))
    end
    it 'has model' do
      post :create, valid_attributes
      assigns(:organization).should be_a(Organization)
      assigns(:organization).should be_persisted
    end
  end

  describe 'GET details' do
    it 'redirect' do
      post :create, valid_attributes
      response.should render_template("organizations/details")
      #response.header['Content-Type'].should include 'application/pdf'
    end
  end


end
