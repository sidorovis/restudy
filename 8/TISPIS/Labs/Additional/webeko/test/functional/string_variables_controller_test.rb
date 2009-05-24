require 'test_helper'

class StringVariablesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:string_variables)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create string_variable" do
    assert_difference('StringVariable.count') do
      post :create, :string_variable => { }
    end

    assert_redirected_to string_variable_path(assigns(:string_variable))
  end

  test "should show string_variable" do
    get :show, :id => string_variables(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => string_variables(:one).to_param
    assert_response :success
  end

  test "should update string_variable" do
    put :update, :id => string_variables(:one).to_param, :string_variable => { }
    assert_redirected_to string_variable_path(assigns(:string_variable))
  end

  test "should destroy string_variable" do
    assert_difference('StringVariable.count', -1) do
      delete :destroy, :id => string_variables(:one).to_param
    end

    assert_redirected_to string_variables_path
  end
end
