require 'test_helper'
module Admin
class BugStatusesControllerTest < ActionController::TestCase

	include AuthenticatedTestHelper
	
  test "should_get_index" do
    login_as('root')
    assert session[:user_id]
    get :index
    assert_response :success
    assert_not_nil assigns(:bug_statuses)
  end

  test "should get new" do
    login_as('root')
    assert session[:user_id]
    get :new
    assert_response :success
  end

  test "should create bug_status" do
    login_as('root')
    assert session[:user_id]
    assert_difference('BugStatus.count') do
      post :create, :bug_status => { :title=>'title', :description =>'description' }
    end

    assert_redirected_to admin_bug_status_path(assigns(:bug_status))
  end

  test "should show bug_status" do
    login_as('root')
    assert session[:user_id]
    get :show, :id => bug_statuses(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    login_as('root')
    assert session[:user_id]
    get :edit, :id => bug_statuses(:one).to_param
    assert_response :success
  end

  test "should update bug_status" do
    login_as('root')
    assert session[:user_id]
    put :update, :id => bug_statuses(:one).to_param, :bug_status => { }
    assert_redirected_to admin_bug_status_path(assigns(:bug_status))
  end

  test "should destroy bug_status" do
    login_as('root')
    assert session[:user_id]
    assert_difference('BugStatus.count', -1) do
      delete :destroy, :id => bug_statuses(:one).to_param
    end

    assert_redirected_to admin_bug_statuses_path
  end
    
end
end
