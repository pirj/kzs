require 'spec_helper'

describe OrganizationsController do
  def valid_attributes
    { organization: {
        title: Faker::Lorem.sentence,
      }
    }
  end
  let!(:organization) { Organization.make!(title: 'Bell') }
  let!(:user) { User.make!(organization: organization) }
  before :each do
    sign_in user
  end

  context 'GET index' do
    let!(:organization_2) { Organization.make!(title: 'Apple') }
    it 'assigns all Organization with decorator' do
      get :index, sort: 'title', direction: 'asc'
      assigns(:organizations).should be_decorated_with Organizations::ListDecorator
      assigns(:organizations).first.should eq(organization_2)
    end
  end

  context 'POST create' do
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

  context 'GET details' do
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

  context 'GET show' do
    #let!(:organization) { Organization.make! }
    it 'response status and template with decorator' do
      get :show, id: organization.id
      assigns(:organization).should be_decorated_with Organizations::ShowDecorator
      expect(response.status).to eq(200)
    end
    it 'render view show' do
      get :show, id: organization.id
      response.should render_template(:show)
    end
  end

  context 'PUT update' do
    it 'assigns the requested organization as @organization' do
      put :update, id: organization.id, organization: {title: 'new title'}
      assigns(:organization).title.should eq('new title')
    end
    it 'redirect' do
      put :update, id: organization.id, organization: {title: 'new title'}
      response.should redirect_to(edit_organization_path(organization.id))
    end

  end


  context 'DELETE destroy' do
    it 'destroy organization' do
      expect { delete :destroy, {id: organization.id}
             }.to change(Organization, :count).by(-1)
    end
    it 'redirect' do
      delete :destroy, {id: organization.id}
      response.should redirect_to(organizations_path)
    end
  end

  context 'GET edit' do
    it 'render template with decorator' do
      get :edit, id: organization.id
      assigns(:organization).should be_decorated_with Organizations::EditDecorator
    end
  end

end
