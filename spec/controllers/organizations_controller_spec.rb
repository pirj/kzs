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
    let!(:organization) { Organization.make! }
    it 'response status' do
      get :details, id: organization.id, format: :pdf
      expect(response.status).to eq(200)
    end
    it 'render view details' do
      get :details, id: organization.id, format: :pdf
      response.should render_template(:details)
    end
  end

  describe 'GET show' do
    let!(:organization) { Organization.make! }
    it 'response status' do
      get :show, id: organization.id
      expect(response.status).to eq(200)
    end
    it 'render view show' do
      get :show, id: organization.id
      response.should render_template(:show)
    end
  end

  describe 'PUT update' do
    let!(:organization) { Organization.make! }
    let!(:organization_new) { Organization.make!(title: 'new title')}
    it 'response status' do
      put :update, {id: organization.id}, title: 'new title'
      organization.title.should eq(title)
      expect(response.status).to eq(200)
    end
    it 'assigns the requested organization as @organization' do
      put :update, {id: organization.id}, organization: organization_new
    end
  end




end
