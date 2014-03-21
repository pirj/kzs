require 'spec_helper'

describe Admin::PermitsController do
  before { pending }
  render_views
  def valid_attributes
    { permit: {
        number: 'number_new',
        start_date: Date.today,
        expiration_date: Date.today + 5.days
      }
    }
  end
  let!(:permit) { Permit.make!}
  let!(:user) { User.make!(sys_user: true)}
  before :each do
    sign_in(user)
  end

  context 'GET index' do
    it 'assigns all Permits' do
      get :index
      expect(response.status).to eq(200)
    end
  end

  context 'GET new' do
    it 'new_admin_permit_path' do
      get :new
      response.status.should be(200)
    end
  end

  context 'POST create' do
    it 'new object Permit' do
      expect { post :create, valid_attributes
      }.to change(Permit, :count).by(1)
    end
    it 'redirect' do
      post :create, valid_attributes
      response.should redirect_to(admin_permit_path(Permit.last))
    end
    it 'has model' do
      post :create, valid_attributes
      assigns(:permit).should be_a(Permit)
      assigns(:permit).should be_persisted
    end
  end

  context 'GET show' do
    it 'response status and template with decorator' do
      get :show, id: permit.id
      response.status.should be(200)
    end
    it 'render view show' do
      get :show, id: permit.id
      response.should render_template(:show)
    end
  end

  context 'PUT update' do
    it 'assigns the requested permit as @permit' do
      put :update, id: permit.id, permit: {number: 'number_new'}
      assigns(:permit).number.should eq('number_new')
    end
    it 'redirect' do
      put :update, id: permit.id, permit: {number: 'number_new'}
      response.should redirect_to(admin_permit_path(permit.id))
    end
  end


  context 'DELETE destroy' do
    it 'destroy permit' do
      expect { delete :destroy, {id: permit.id}
      }.to change(Permit, :count).by(-1)
    end
    it 'redirect' do
      delete :destroy, {id: permit.id}
      response.should redirect_to(admin_permits_path)
    end
  end

  context 'GET edit' do
    it 'render template with decorator' do
      get :edit, id: permit.id
      response.status.should be(200)
    end
  end

end
