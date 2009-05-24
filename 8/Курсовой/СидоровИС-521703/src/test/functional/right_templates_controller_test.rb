require 'test_helper'
module Admin
class RightTemplatesControllerTest < ActionController::TestCase
	include AuthenticatedTestHelper

  test "should get new" do
    login_as('root')
    assert session[:user_id]
    get :new, :role_template_id => 2
    assert_response :success
  end

  test "should create right_template" do
    login_as('root')
    assert session[:user_id]
    assert_difference('RightTemplate.count') do
      post :create, :right_template => {:title=> 'ole' , :description=> 'ole' }, :role_template_id => 2
    end

    assert_redirected_to admin_role_template_right_template_path( 2 , assigns(:right_template))
  end

  test "should show right_template" do
    login_as('root')
    assert session[:user_id]
    get :show, :id => right_templates(:one).to_param, :role_template_id => 2
    assert_response :success
  end

  test "should get edit" do
    login_as('root')
    assert session[:user_id]
    get :edit, :id => right_templates(:one).to_param, :role_template_id => 2
    assert_response :success
  end

  test "should update right_template" do
    login_as('root')
    assert session[:user_id]
    put :update, :id => right_templates(:one).to_param, :right_template => { }, :role_template_id => 2
    assert_redirected_to admin_role_template_right_template_path( 2, assigns(:right_template))
  end

  test "should destroy right_template" do
    login_as('root')
    assert session[:user_id]
    assert_difference('RightTemplate.count', -1) do
      delete :destroy, :id => right_templates(:one).to_param, :role_template_id => 2
    end

    assert_redirected_to admin_role_template_path( 2 )
  end
end
end
