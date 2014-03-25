require 'spec_helper'

describe Admin::VehiclesController do
  before { pending }
  render_views
  def valid_attributes
    { vehicle: {
      sn_number: 222
    }
    }
  end
  let!(:vehicle) { Vehicle.make! }
  let!(:user) { User.make!(sys_user: true) }
  before :each do
    sign_in(user)
  end

  context 'GET index' do
    it 'assigns all Vehicles' do
      get :index
      expect(response.status).to eq(200)
    end
  end

  context 'GET new' do
    it 'new_admin_vehicle_path' do
      get :new
      response.status.should be(200)
    end
  end

  context 'POST create' do
    it 'new object Vehicle' do
      expect do post :create, valid_attributes
      end.to change(Vehicle, :count).by(1)
    end
    it 'redirect' do
      post :create, valid_attributes
      response.should redirect_to(admin_vehicle_path(Vehicle.last))
    end
    it 'has model' do
      post :create, valid_attributes
      assigns(:vehicle).should be_a(Vehicle)
      assigns(:vehicle).should be_persisted
    end
  end

  context 'GET show' do
    it 'response status and template with decorator' do
      get :show, id: vehicle.id
      response.status.should be(200)
    end
    it 'render view show' do
      get :show, id: vehicle.id
      response.should render_template(:show)
    end
  end

  context 'PUT update' do
    it 'assigns the requested vehicle as @vehicle' do
      put :update, id: vehicle.id, vehicle: { sn_number: '222' }
      assigns(:vehicle).sn_number.should eq('222')
    end
    it 'redirect' do
      put :update, id: vehicle.id, vehicle: { sn_number: '222' }
      response.should redirect_to(admin_vehicle_path(vehicle.id))
    end
  end

  context 'DELETE destroy' do
    it 'destroy vehicle' do
      expect do delete :destroy, id: vehicle.id
      end.to change(Vehicle, :count).by(-1)
    end
    it 'redirect' do
      delete :destroy, id: vehicle.id
      response.should redirect_to(admin_vehicles_path)
    end
  end

  context 'GET edit' do
    it 'render template with decorator' do
      get :edit, id: vehicle.id
      response.status.should be(200)
    end
  end

end
