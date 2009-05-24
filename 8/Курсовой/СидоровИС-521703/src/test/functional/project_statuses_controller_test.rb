require 'test_helper'
module Admin
class ProjectStatusesControllerTest < ActionController::TestCase

	include AuthenticatedTestHelper

  test "should get index" do
    login_as('root')
    assert session[:user_id]
    get :index
    assert_response :success
    assert_not_nil assigns(:project_statuses)
  end

  test "should get new" do
    login_as('root')
    assert session[:user_id]
    get :new
    assert_response :success
  end

  test "should create project_status" do
    login_as('root')
    assert session[:user_id]
    assert_difference('ProjectStatus.count') do
      post :create, :project_status => {:title=>'Help',:description=>'ole' }
    end

    assert_redirected_to admin_project_status_path(assigns(:project_status))
  end

  test "should show project_status" do
    login_as('root')
    assert session[:user_id]
    get :show, :id => project_statuses(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    login_as('root')
    assert session[:user_id]
    get :edit, :id => project_statuses(:one).to_param
    assert_response :success
  end

  test "should update project_status" do
    login_as('root')
    assert session[:user_id]
    put :update, :id => project_statuses(:one).to_param, :project_status => { }
    assert_redirected_to admin_project_status_path(assigns(:project_status))
  end

  test "should destroy project_status" do
    login_as('root')
    assert session[:user_id]
    assert_difference('ProjectStatus.count', -1) do
      delete :destroy, :id => project_statuses(:one).to_param
    end

    assert_redirected_to admin_project_statuses_path
  end
end
end