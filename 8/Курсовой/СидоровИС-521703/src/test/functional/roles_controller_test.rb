require 'test_helper'

class RolesControllerTest < ActionController::TestCase

	include AuthenticatedTestHelper

  test "should get new" do
    login_as('quentin')
    assert session[:user_id]
    get :new, :project_id => 2
    assert_response :success
  end

  test "should create role" do
    login_as('quentin')
    assert session[:user_id]
    assert_difference('Role.count') do
      post :create, :role => {:title=>'hello', :description=>'world', :role_template_id => 2, :user_id => 2 }, :project_id => 2
    end

    assert_redirected_to project_role_path(2,assigns(:role))
  end

  test "should show role" do
    login_as('quentin')
    assert session[:user_id]
    get :show, :id => roles(:one).to_param, :project_id => 2
    assert_response :success
  end

  test "should get edit" do
    login_as('quentin')
    assert session[:user_id]
    get :edit, :id => roles(:one).to_param, :project_id => 2
    assert_response :success
  end

  test "should update role" do
    login_as('quentin')
    assert session[:user_id]
    put :update, :id => roles(:one).to_param, :role => { }, :project_id => 2
    assert_redirected_to project_role_path(2, assigns(:role))
  end

  test "should destroy role" do
    login_as('quentin')
    assert session[:user_id]
    assert_difference('Role.count', -1) do
      delete :destroy, :id => roles(:one).to_param, :project_id => 2
    end

    assert_redirected_to project_path( 2 )
  end
end
