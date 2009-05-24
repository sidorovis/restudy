require 'test_helper'

class ProjectsControllerTest < ActionController::TestCase

	include AuthenticatedTestHelper

  test "should get index" do
    login_as('quentin')
    assert session[:user_id]
    get :index
    assert_response :success
    assert_not_nil assigns(:projects)
  end

  test "should get new" do
    login_as('quentin')
    assert session[:user_id]
    get :new
    assert_response :success
  end

  test "should create project" do
    login_as('quentin')
    assert session[:user_id]
    assert_difference('Project.count') do
      post :create, :project => {:title=>'project_title', :description=>'descr' }
    end

    assert_redirected_to project_path(assigns(:project))
  end

  test "should show project" do
    login_as('quentin')
    assert session[:user_id]
    get :show, :id => projects(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    login_as('quentin')
    assert session[:user_id]
    get :edit, :id => projects(:one).to_param
    assert_response :success
  end

  test "should update project" do
    login_as('quentin')
    assert session[:user_id]
    put :update, :id => projects(:one).to_param, :project => { }
    assert_redirected_to project_path(assigns(:project))
  end

  test "should destroy project" do
    login_as('quentin')
    assert session[:user_id]
    assert_difference('Project.count', -1) do
      delete :destroy, :id => projects(:one).to_param
    end

    assert_redirected_to projects_path
  end
end
