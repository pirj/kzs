require 'spec_helper'


describe Admin::OrganizationsController do
  render_views
  def valid_attributes
    { organization: {
        title: 'title_new'
    }
    }
  end
  let!(:organization) { Organization.make!}
  let!(:user) { User.make!(sys_user: true)}
  before :each do
    sign_in(user)
  end

  context 'GET index' do
    it 'assigns all Organizations' do
      get :index
      expect(response.status).to eq(200)
    end
  end

  context 'GET new' do
    it 'new_admin_organization_path' do
      get :new
      response.status.should be(200)
    end
  end

  context 'POST create' do
    it 'new object Organization' do
      expect { post :create, valid_attributes
      }.to change(Organization, :count).by(1)
    end
    it 'redirect' do
      post :create, valid_attributes
      response.should redirect_to(admin_organization_path(Organization.last))
    end
    it 'has model' do
      post :create, valid_attributes
      assigns(:organization).should be_a(Organization)
      assigns(:organization).should be_persisted
    end
  end

  context 'GET show' do
    it 'response status and template with decorator' do
      get :show, id: organization.id
      response.status.should be(200)
    end
    it 'render view show' do
      get :show, id: organization.id
      response.should render_template(:show)
    end
  end

  context 'PUT update' do
    it 'assigns the requested organization as @organization' do
      put :update, id: organization.id, organization: {title: 'title_new'}
      assigns(:organization).title.should eq('title_new')
    end
    it 'redirect' do
      put :update, id: organization.id, organization: {title: 'title_new'}
      response.should redirect_to(admin_organization_path(organization.id))
    end
  end


  context 'DELETE destroy' do
    it 'destroy organization' do
      expect { delete :destroy, {id: organization.id}
      }.to change(Organization, :count).by(-1)
    end
    it 'redirect' do
      delete :destroy, {id: organization.id}
      response.should redirect_to(admin_organizations_path)
    end
  end

  context 'GET edit' do
    it 'render template with decorator' do
      get :edit, id: organization.id
      response.status.should be(200)
    end
  end

end
