require 'test_helper'
module Admin
class BuildStatusesControllerTest < ActionController::TestCase

	include AuthenticatedTestHelper

	setup :authenticate_as_root
	
	def authenticate_as_root
		login_as('root')
		assert session[:user_id]
	end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:build_statuses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create build_status" do
    assert_difference('BuildStatus.count') do
      post :create, :build_status => { :title => 'hello', :description => 'world' }
    end

    assert_redirected_to admin_build_status_path(assigns(:build_status))
  end

  test "should show build_status" do
    get :show, :id => build_statuses(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => build_statuses(:one).to_param
    assert_response :success
  end

  test "should update build_status" do
    put :update, :id => build_statuses(:one).to_param, :build_status => { }
    assert_redirected_to admin_build_status_path(assigns(:build_status))
  end

  test "should destroy build_status" do
    assert_difference('BuildStatus.count', -1) do
      delete :destroy, :id => build_statuses(:one).to_param
    end

    assert_redirected_to admin_build_statuses_path
  end
end
end
