require 'test_helper'

class WfAttributesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:wf_attributes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create wf_attribute" do
    assert_difference('WfAttribute.count') do
      post :create, :wf_attribute => { }
    end

    assert_redirected_to wf_attribute_path(assigns(:wf_attribute))
  end

  test "should show wf_attribute" do
    get :show, :id => wf_attributes(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => wf_attributes(:one).id
    assert_response :success
  end

  test "should update wf_attribute" do
    put :update, :id => wf_attributes(:one).id, :wf_attribute => { }
    assert_redirected_to wf_attribute_path(assigns(:wf_attribute))
  end

  test "should destroy wf_attribute" do
    assert_difference('WfAttribute.count', -1) do
      delete :destroy, :id => wf_attributes(:one).id
    end

    assert_redirected_to wf_attributes_path
  end
end
