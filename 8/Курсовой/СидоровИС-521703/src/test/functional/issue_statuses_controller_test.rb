require 'test_helper'
module Admin
class IssueStatusesControllerTest < ActionController::TestCase

	include AuthenticatedTestHelper

  test "should get index" do
    login_as('root')
    assert session[:user_id]
    get :index
    assert_response :success
    assert_not_nil assigns(:issue_statuses)
  end

  test "should get new" do
    login_as('root')
    assert session[:user_id]
    get :new
    assert_response :success
  end

  test "should create issue_status" do
    login_as('root')
    assert session[:user_id]
    assert_difference('IssueStatus.count') do
      post :create, :issue_status => { :title => 'some title', :description => 'description' }
    end

    assert_redirected_to admin_issue_status_path(assigns(:issue_status))
  end

  test "should show issue_status" do
    login_as('root')
    assert session[:user_id]
    get :show, :id => issue_statuses(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    login_as('root')
    assert session[:user_id]
    get :edit, :id => issue_statuses(:one).to_param
    assert_response :success
  end

  test "should update issue_status" do
    login_as('root')
    assert session[:user_id]
    put :update, :id => issue_statuses(:one).to_param, :issue_status => { }
    assert_redirected_to admin_issue_status_path(assigns(:issue_status))
  end

  test "should destroy issue_status" do
    login_as('root')
    assert session[:user_id]
    assert_difference('IssueStatus.count', -1) do
      delete :destroy, :id => issue_statuses(:one).to_param
    end

    assert_redirected_to admin_issue_statuses_path
  end
end
end
