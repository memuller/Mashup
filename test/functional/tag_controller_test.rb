require 'test_helper'

class TagControllerTest < ActionController::TestCase

  test "only blog with tag" do
		get :blog, {'tag' => "phn"} 
		assert_not_nil( assigns(:content), "need return some result for tag PHN" )
    assert_response :success
  end

  test "only blog without tag" do
		get :blog 
		assert_not_nil( assigns(:content), "need return some result for cancaonova" )		
    assert_response :success
  end
		
  test "all media content" do
#		get(:index, {"tag" => "phn"})
 #   assert_response :success
  end

end
