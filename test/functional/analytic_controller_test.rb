require 'test_helper'

class AnalyticControllerTest < ActionController::TestCase

  test "get last tags access" do
		get :index
    assert :success
		assert_not_nil assigns(:data)
  end
end
