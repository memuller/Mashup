require 'test_helper'

class TagControllerTest < ActionController::TestCase

	test "add object flash video" do
#		flunk 'Not done testing yet.'
	end

  test "duplicate entrie microtext with phn" do
		get :microtext, {'tag' => "phn"} 
		assert_not_equal( assigns["content"][0][0], assigns["content"][1][0], "duplicate entries for PHN" )
  end

  test "only blog with tag" do
		get :blog, {'tag' => "phn"} 
		assert_not_equal( 0, assigns(:content).size, "need some POST for PHN" )
    assert_response :success
  end

  test "only blog with tag dunga" do
		get :blog, {'tag' => "dunga"} 
		assert_not_equal( 0, assigns(:content).size, "need some POST for DUNGA" )
    assert_response :success
  end

  test "only blog without tag" do
		get :blog 
		assert_not_nil( assigns(:content), "need return some POST for cancaonova" )		
    assert_response :success
  end
		
  test "only bookmark with tag" do
		get :bookmark, {'tag' => "phn"} 
    assert_response :success
		assert_not_equal( 0, assigns(:content).size, "need some BOOKMARK for PHN" )
		assert_template 'tag/bookmark'
  end

  test "only microtext with DUNGA" do
		get :microtext, {'tag' => "dunga"} 
    assert_response :success
		assert_not_equal( 0, assigns(:content).size, "need some MICROTEXT for DUNGA" )
		assert_template 'tag/microtext'    
  end

  test "video DUNGA" do
		get :video, {'tag' => "dunga"} 
    assert_response :success
		assert_not_equal( 0, assigns(:content).size, "need some VIDEO for DUNGA" )
		assert_template 'tag/video'    
  end

  test "photo DUNGA" do
		get :photo, {'tag' => "dunga"} 
    assert_response :success
		assert_no_tag :tag => "div", :descendant => {:tag => "small",:attributes => { :class => "no-entrie" }} 
		assert_template 'tag/photo'    
  end

  test "all media content" do
		get(:index, {"tag" => "phn"})
    assert_response :success
  end

end
