require 'test_helper'

class WordGroupsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:word_groups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create word_group" do
    assert_difference('WordGroup.count') do
      post :create, :word_group => { }
    end

    assert_redirected_to word_group_path(assigns(:word_group))
  end

  test "should show word_group" do
    get :show, :id => word_groups(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => word_groups(:one).id
    assert_response :success
  end

  test "should update word_group" do
    put :update, :id => word_groups(:one).id, :word_group => { }
    assert_redirected_to word_group_path(assigns(:word_group))
  end

  test "should destroy word_group" do
    assert_difference('WordGroup.count', -1) do
      delete :destroy, :id => word_groups(:one).id
    end

    assert_redirected_to word_groups_path
  end
end
