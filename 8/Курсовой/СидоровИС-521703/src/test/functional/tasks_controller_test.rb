require 'test_helper'

class TasksControllerTest < ActionController::TestCase

	include AuthenticatedTestHelper

  test "should get index" do
    login_as( 'quentin' )
    get :index, :project_id => 1
    assert_response :success
    assert_not_nil assigns(:tasks)
  end

  test "should get new" do
    login_as( 'quentin' )
    assert session[:user_id]
    get :new, :project_id => 1
    assert_response :success
  end

  test "should create task" do
    login_as( 'quentin' )
    assert session[:user_id]
    assert_difference('Task.count') do
      post :create, :task => {:title => 'task', :description=>'sddd', :project_id => '2', :task_status_id => task_statuses(:one).to_param }, :project_id => 1
    end

    assert_redirected_to project_task_path(1,assigns(:task))
  end

  test "should show task" do
    login_as( 'quentin' )
    assert session[:user_id]
    get :show, :id => tasks(:one).to_param, :project_id => 1
    assert_response :success
  end

  test "should get edit" do
    login_as( 'quentin' )
    assert session[:user_id]
    get :edit, :id => tasks(:one).to_param, :project_id => 1
    assert_response :success
  end

  test "should update task" do
    login_as( 'quentin' )
    assert session[:user_id]
    put :update, :id => tasks(:one).to_param, :task => { }, :project_id => 1
    assert_redirected_to project_task_path(1,assigns(:task))
  end

  test "should destroy task" do
    login_as( 'quentin' )
    assert session[:user_id]
    assert_difference('Task.count', -1) do
      delete :destroy, :id => tasks(:one).to_param, :project_id => 1
    end

    assert_redirected_to project_tasks_path(1)
  end
end
