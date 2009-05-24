require 'test_helper'

module Admin
class RoleTemplatesControllerTest < ActionController::TestCase

	include AuthenticatedTestHelper

  test "should get index" do
    login_as('root')
    assert session[:user_id]
    get :index
    assert_response :success
    assert_not_nil assigns(:role_templates)
  end

  test "should get new" do
    login_as('root')
    assert session[:user_id]
    get :new
    assert_response :success
  end

  test "should create role_template" do
    login_as('root')
    assert session[:user_id]
    assert_difference('RoleTemplate.count') do
      post :create, :role_template => { :title => 'RoleName', :description => 'desc' }
    end

    assert_redirected_to admin_role_template_path(assigns(:role_template))
  end

  test "should show role_template" do
    login_as('root')
    assert session[:user_id]
    get :show, :id => role_templates(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    login_as('root')
    assert session[:user_id]
    get :edit, :id => role_templates(:one).to_param
    assert_response :success
  end

  test "should update role_template" do
    login_as('root')
    assert session[:user_id]
    put :update, :id => role_templates(:one).to_param, :role_template => { }
    assert_redirected_to admin_role_template_path(assigns(:role_template))
  end

  test "should destroy role_template" do
    login_as('root')
    assert session[:user_id]
    assert_difference('RoleTemplate.count', -1) do
      delete :destroy, :id => role_templates(:one).to_param
    end

    assert_redirected_to admin_role_templates_path
  end
end
end
