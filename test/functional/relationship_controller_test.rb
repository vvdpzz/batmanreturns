require 'test_helper'

class RelationshipControllerTest < ActionController::TestCase
  test "should get follow" do
    get :follow
    assert_response :success
  end

  test "should get undo" do
    get :undo
    assert_response :success
  end

end
