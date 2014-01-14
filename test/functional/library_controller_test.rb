require 'test_helper'

class LibraryControllerTest < ActionController::TestCase
  test "should get library" do
    get :library
    assert_response :success
  end

end
