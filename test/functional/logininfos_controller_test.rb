require 'test_helper'

class LogininfosControllerTest < ActionController::TestCase
  setup do
    @logininfo = logininfos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:logininfos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create logininfo" do
    assert_difference('Logininfo.count') do
      post :create, :logininfo => @logininfo.attributes
    end

    assert_redirected_to logininfo_path(assigns(:logininfo))
  end

  test "should show logininfo" do
    get :show, :id => @logininfo.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @logininfo.to_param
    assert_response :success
  end

  test "should update logininfo" do
    put :update, :id => @logininfo.to_param, :logininfo => @logininfo.attributes
    assert_redirected_to logininfo_path(assigns(:logininfo))
  end

  test "should destroy logininfo" do
    assert_difference('Logininfo.count', -1) do
      delete :destroy, :id => @logininfo.to_param
    end

    assert_redirected_to logininfos_path
  end
end
