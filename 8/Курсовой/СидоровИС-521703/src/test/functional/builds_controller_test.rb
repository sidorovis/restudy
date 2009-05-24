require 'test_helper'

class BuildsControllerTest < ActionController::TestCase

	include AuthenticatedTestHelper

  setup :authenticate_as_user
  
  def authenticate_as_user
	login_as('quentin')
	assert session[:user_id]
  end

  test "should get index" do
    get :index, :project_id => 1
    assert_response :success
    assert_not_nil assigns(:builds)
  end

  test "should get new" do
    get :new, :project_id => 1
    assert_response :success
  end

  test "should create build" do
    assert_difference('Build.count') do
      post :create, :build => { :title=>'b', :description=>'descr', :build_status_id => build_statuses(:two).to_param }, :project_id => 1
    end

    assert_redirected_to project_build_path(1,assigns(:build))
  end

  test "should show build" do
    get :show, :id => builds(:one).to_param, :project_id => 1
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => builds(:one).to_param, :project_id => 1
    assert_response :success
  end

  test "should update build" do
    put :update, :id => builds(:one).to_param, :build => { }, :project_id => 1
    assert_redirected_to project_build_path(1,assigns(:build))
  end

  test "should destroy build" do
    assert_difference('Build.count', -1) do
      delete :destroy, :id => builds(:one).to_param, :project_id => 1
    end

    assert_redirected_to project_builds_path(1)
  end
end
