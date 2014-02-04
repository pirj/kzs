require 'spec_helper'

describe OrganizationsController do
  describe 'GET index' do
    let!(:organization) { Organization.make! }
    it 'assigns all Organization' do
      get :index
      assigns(:posts).should eq([post])
    end
  end
end
