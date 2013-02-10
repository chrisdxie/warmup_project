require 'test_helper'

class SiteControllerTest < ActionController::TestCase
  test "should get login" do
    get :login
    assert_response :success
  end

  test "should get add" do
    get :add
    assert_response :success
  end

  test "should get resetFixture" do
    get :resetFixture
    assert_response :success
  end

  test "should get unitTests" do
    get :unitTests
    assert_response :success
  end

end
