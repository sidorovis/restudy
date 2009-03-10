require 'test_helper'

class WordTypesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:word_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create word_type" do
    assert_difference('WordType.count') do
      post :create, :word_type => { }
    end

    assert_redirected_to word_type_path(assigns(:word_type))
  end

  test "should show word_type" do
    get :show, :id => word_types(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => word_types(:one).id
    assert_response :success
  end

  test "should update word_type" do
    put :update, :id => word_types(:one).id, :word_type => { }
    assert_redirected_to word_type_path(assigns(:word_type))
  end

  test "should destroy word_type" do
    assert_difference('WordType.count', -1) do
      delete :destroy, :id => word_types(:one).id
    end

    assert_redirected_to word_types_path
  end
end
