require 'test_helper'

class AnalyticControllerTest < ActionController::TestCase

  test "get last tags access" do
		get :index
    assert :success
		assert_not_nil assigns(:data)
  end

  test "get last tags access in english" do
		get :index, {'locale' => "en"} 
    assert :success
		assert_not_nil assigns(:data)
  end

  test "get last tags access in spanish" do
		get :index, {'locale' => "es"} 
    assert :success
		assert_not_nil assigns(:data)
  end


end
