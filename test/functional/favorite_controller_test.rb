require 'test_helper'

class FavoriteControllerTest < ActionController::TestCase
  test "should get favorite" do
    get :favorite
    assert_response :success
  end

  test "should get undo" do
    get :undo
    assert_response :success
  end

end
