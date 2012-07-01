require 'test_helper'

class OrderControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get join" do
    get :join
    assert_response :success
  end

  test "should get control" do
    get :control
    assert_response :success
  end

  test "should get choose" do
    get :choose
    assert_response :success
  end

end
