require 'test_helper'

class MashupControllerTest < ActionController::TestCase

  test "the blog" do
		get :blog
    assert_response :success
  end

end
