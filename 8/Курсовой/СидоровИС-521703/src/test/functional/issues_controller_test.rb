require 'test_helper'

class IssuesControllerTest < ActionController::TestCase

	include AuthenticatedTestHelper

  test "should get index" do
    login_as('quentin')
    assert session[:user_id]
    get :index, :project_id => 1
    assert_response :success
    assert_not_nil assigns(:issues)
  end

  test "should get new" do
    login_as('quentin')
    assert session[:user_id]
    get :new, :project_id => 1
    assert_response :success
  end

  test "should create issue" do
    login_as('quentin')
    assert session[:user_id]
    assert_difference('Issue.count') do
      post :create, :issue => { :title => 'hello' , :description => 'desc', :issue_status_id => 2 }, :project_id => 1
    end

    assert_redirected_to project_issue_path(1,assigns(:issue))
  end

  test "should show issue" do
    login_as('quentin')
    assert session[:user_id]
    get :show, :id => issues(:one).to_param, :project_id => 1
    assert_response :success
  end

  test "should get edit" do
    login_as('quentin')
    assert session[:user_id]
    get :edit, :id => issues(:one).to_param, :project_id => 1
    assert_response :success
  end

  test "should update issue" do
    login_as('quentin')
    assert session[:user_id]
    put :update, :id => issues(:one).to_param, :issue => { }, :project_id => 1
    assert_redirected_to project_issue_path(1,assigns(:issue))
  end

  test "should destroy issue" do
    login_as('quentin')
    assert session[:user_id]
    assert_difference('Issue.count', -1) do
      delete :destroy, :id => issues(:one).to_param, :project_id => 1
    end

    assert_redirected_to project_issues_path(1)
  end
end
