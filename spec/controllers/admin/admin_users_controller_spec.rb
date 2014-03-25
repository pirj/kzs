require 'spec_helper'
include Devise::TestHelpers

describe Admin::UsersController do
  before { pending }
  render_views
  def valid_attributes
    { user: {
      username: 'username_new'
      }
    }
  end
  let!(:user) { User.make!(sys_user: true) }
  before :each do
    sign_in(user)
  end

  context 'GET index' do
    it 'assigns all Users' do
      get :index
      expect(response.status).to eq(200)
    end
  end

  context 'GET new' do
    it 'new_admin_user_path' do
      get :new
      response.status.should be(200)
    end
  end

  context 'POST create' do
    it 'new object User' do
      expect do post :create, valid_attributes
      end.to change(User, :count).by(1)
    end
    it 'redirect' do
      post :create, valid_attributes
      response.should redirect_to(admin_user_path(User.last))
    end
    it 'has model' do
      post :create, valid_attributes
      assigns(:user).should be_a(User)
      assigns(:user).should be_persisted
    end
  end

  context 'GET show' do
    it 'response status and template with decorator' do
      get :show, id: user.id
      response.status.should be(200)
    end
    it 'render view show' do
      get :show, id: user.id
      response.should render_template(:show)
    end
  end

  context 'PUT update' do
    it 'assigns the requested group as @group' do
      put :update, id: user.id, user: { first_name: 'Andrey' }
      assigns(:user).first_name.should eq('Andrey')
    end
    it 'redirect' do
      put :update, id: user.id, user: { first_name: 'Andrey' }
      response.should redirect_to(admin_user_path(user.id))
    end
  end

  context 'DELETE destroy' do
    it 'destroy group' do
      expect do delete :destroy, id: user.id
      end.to change(User, :count).by(-1)
    end
    it 'redirect' do
      delete :destroy, id: user.id
      response.should redirect_to(admin_users_path)
    end
  end

  context 'GET edit' do
    it 'render template with decorator' do
      get :edit, id: user.id
      response.status.should be(200)
    end
  end

end
