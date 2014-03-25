require 'spec_helper'

describe Admin::GroupsController do
  before { pending }
  render_views
  def valid_attributes
    { group: {
      title: 'title_new'
    }
    }
  end
  let!(:group) { Group.make! }
  let!(:user) { User.make!(sys_user: true) }
  before :each do
    sign_in(user)
  end

  context 'GET index' do
    it 'assigns all Groups' do
      get :index
      expect(response.status).to eq(200)
    end
  end

  context 'GET new' do
    it 'new_admin_group_path' do
      get :new
      response.status.should be(200)
    end
  end

  context 'POST create' do
    it 'new object Group' do
      expect do post :create, valid_attributes
      end.to change(Group, :count).by(1)
    end
    it 'redirect' do
      post :create, valid_attributes
      response.should redirect_to(admin_group_path(Group.last))
    end
    it 'has model' do
      post :create, valid_attributes
      assigns(:group).should be_a(Group)
      assigns(:group).should be_persisted
    end
  end

  context 'GET show' do
    it 'response status and template with decorator' do
      get :show, id: group.id
      response.status.should be(200)
    end
    it 'render view show' do
      get :show, id: group.id
      response.should render_template(:show)
    end
  end

  context 'PUT update' do
    it 'assigns the requested group as @group' do
      put :update, id: group.id, group: { title: 'title_new' }
      assigns(:group).title.should eq('title_new')
    end
    it 'redirect' do
      put :update, id: group.id, group: { title: 'title_new' }
      response.should redirect_to(admin_group_path(group.id))
    end
  end

  context 'DELETE destroy' do
    it 'destroy group' do
      expect do delete :destroy, id: group.id
      end.to change(Group, :count).by(-1)
    end
    it 'redirect' do
      delete :destroy, id: group.id
      response.should redirect_to(admin_groups_path)
    end
  end

  context 'GET edit' do
    it 'render template with decorator' do
      get :edit, id: group.id
      response.status.should be(200)
    end
  end

end
