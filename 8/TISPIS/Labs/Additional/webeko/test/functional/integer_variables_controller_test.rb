require 'test_helper'

class IntegerVariablesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:integer_variables)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create integer_variable" do
    assert_difference('IntegerVariable.count') do
      post :create, :integer_variable => { }
    end

    assert_redirected_to integer_variable_path(assigns(:integer_variable))
  end

  test "should show integer_variable" do
    get :show, :id => integer_variables(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => integer_variables(:one).to_param
    assert_response :success
  end

  test "should update integer_variable" do
    put :update, :id => integer_variables(:one).to_param, :integer_variable => { }
    assert_redirected_to integer_variable_path(assigns(:integer_variable))
  end

  test "should destroy integer_variable" do
    assert_difference('IntegerVariable.count', -1) do
      delete :destroy, :id => integer_variables(:one).to_param
    end

    assert_redirected_to integer_variables_path
  end
end
