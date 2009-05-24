require 'test_helper'

class BugsControllerTest < ActionController::TestCase

	include AuthenticatedTestHelper

  test "should get index" do
    login_as('quentin')
    assert session[:user_id]
    get :index, :project_id => 1, :build_id => builds(:one).to_param
    assert_response :success
    assert_not_nil assigns(:bugs)
  end

  test "should get new" do
    login_as('quentin')
    assert session[:user_id]
    get :new, :project_id => 1, :build_id => builds(:one).to_param
    assert_response :success
  end

  test "should create bug" do
    login_as('quentin')
    assert session[:user_id]
    assert_difference('Bug.count') do
      post :create, :bug => { :title=>'a bug', :description=>'and his description', :bug_status_id => 2 }, :project_id => 1, :build_id => builds(:one).to_param
    end

    assert_redirected_to project_build_bug_path(1,builds(:one).to_param,assigns(:bug))
  end

  test "should show bug" do
    login_as('quentin')
    assert session[:user_id]
    get :show, :id => bugs(:one).to_param, :project_id => 1, :build_id => builds(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    login_as('quentin')
    assert session[:user_id]
    get :edit, :id => bugs(:one).to_param, :project_id => 1, :build_id => builds(:one).to_param
    assert_response :success
  end

  test "should update bug" do
    login_as('quentin')
    assert session[:user_id]
    put :update, :id => bugs(:one).to_param, :bug => { :title => 'olelo' }, :project_id => 1, :build_id => builds(:one).to_param
    assert_redirected_to project_build_bug_path(1, builds(:one).to_param,assigns(:bug))
  end

  test "should destroy bug" do
    login_as('quentin')
    assert session[:user_id]
    assert_difference('Bug.count', -1) do
      delete :destroy, :id => bugs(:one).to_param, :project_id => 1, :build_id => builds(:one).to_param
    end

    assert_redirected_to project_build_bugs_path(1,builds(:one).to_param)
  end
end
