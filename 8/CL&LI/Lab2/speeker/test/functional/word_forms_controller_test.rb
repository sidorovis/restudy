require 'test_helper'

class WordFormsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:word_forms)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create word_form" do
    assert_difference('WordForm.count') do
      post :create, :word_form => { }
    end

    assert_redirected_to word_form_path(assigns(:word_form))
  end

  test "should show word_form" do
    get :show, :id => word_forms(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => word_forms(:one).id
    assert_response :success
  end

  test "should update word_form" do
    put :update, :id => word_forms(:one).id, :word_form => { }
    assert_redirected_to word_form_path(assigns(:word_form))
  end

  test "should destroy word_form" do
    assert_difference('WordForm.count', -1) do
      delete :destroy, :id => word_forms(:one).id
    end

    assert_redirected_to word_forms_path
  end
end
