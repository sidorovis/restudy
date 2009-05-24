require 'test_helper'

class DashboardControllerTest < ActionController::TestCase
	include AuthenticatedTestHelper

  test "the truth" do
    login_as('quentin')
    assert session[:user_id]
    assert true
  end
end
