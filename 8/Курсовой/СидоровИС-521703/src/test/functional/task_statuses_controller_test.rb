require 'test_helper'
module Admin
class TaskStatusesControllerTest < ActionController::TestCase

	include AuthenticatedTestHelper

  test "should get index" do
    login_as('root')
    assert session[:user_id]
    get :index
    assert_response :success
    assert_not_nil assigns(:task_statuses)
  end

  test "should get new" do
    login_as('root')
    assert session[:user_id]
    get :new
    assert_response :success
  end

  test "should create task_status" do
    login_as('root')
    assert session[:user_id]
    assert_difference('TaskStatus.count') do
      post :create, :task_status => { :title=>'ano', :description=>'nymous' }
    end

    assert_redirected_to admin_task_status_path(assigns(:task_status))
  end

  test "should show task_status" do
    login_as('root')
    assert session[:user_id]
    get :show, :id => task_statuses(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    login_as('root')
    assert session[:user_id]
    get :edit, :id => task_statuses(:one).to_param
    assert_response :success
  end

  test "should update task_status" do
    login_as('root')
    assert session[:user_id]
    put :update, :id => task_statuses(:one).to_param, :task_status => { }
    assert_redirected_to admin_task_status_path(assigns(:task_status))
  end

  test "should destroy task_status" do
    login_as('root')
    assert session[:user_id]
    assert_difference('TaskStatus.count', -1) do
      delete :destroy, :id => task_statuses(:one).to_param
    end

    assert_redirected_to admin_task_statuses_path
  end
end
end
