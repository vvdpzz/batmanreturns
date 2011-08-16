require 'test_helper'

class FollowedQuestionControllerTest < ActionController::TestCase
  test "should get followed" do
    get :followed
    assert_response :success
  end

  test "should get undo" do
    get :undo
    assert_response :success
  end

end
