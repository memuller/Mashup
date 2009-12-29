require 'test_helper'

class TagControllerTest < ActionController::TestCase

	test "add object flash video" do
#		flunk 'Not done testing yet.'
	end

  test "atom bookmark" do
		get :bookmark, {:format => "atom", :tag => "phn"}
    assert_response :success
		assert_routing "/bookmark/tag/phn.atom", { :controller => 'tag', :action => 'bookmark', :tag => 'phn', :format => "atom"}
  end

  test "atom blog without TAG" do
		get :blog, {:format => "atom"}
    assert_response :success
  end

  test "duplicate entrie microtext with phn" do
		get :microtext, {'tag' => "phn"} 
		assert_not_equal( assigns["entries"][0][0], assigns["entries"][1][0], "duplicate entries for PHN" )
  end

  test "redirect when change tag" do
		get :index, {'tag' => "oração"} 
		assert_redirected_to options = {:controller => "tag", :action => "index", :tag => "oracao"},"not redirect tag without accent"
  end

  test "only blog with tag" do
		get :blog, {'tag' => "phn"} 
		assert_not_equal( 0, assigns(:entries).size, "need some POST for PHN" )
    assert_response :success
  end

  test "only blog with tag dunga" do
		get :blog, {'tag' => "dunga"} 
		assert_not_equal( 0, assigns(:entries).size, "need some POST for DUNGA" )
    assert_response :success
  end

  test "only blog without tag" do
		get :blog
		assert_not_nil( assigns(:entries).size, "need return some POST for cancaonova" )		
    assert_response :success
  end
		
  test "only bookmark with tag" do
		get :bookmark, {'tag' => "phn"} 
    assert_response :success
		assert_not_equal( 0, assigns(:entries).size, "need some BOOKMARK for PHN" )
		assert_template 'tag/bookmark'
  end

  test "only microtext with DUNGA" do
		get :microtext, {'tag' => "dunga"} 
    assert_response :success
		assert_not_equal( 0, assigns(:entries).size, "need some MICROTEXT for DUNGA" )
		assert_template 'tag/microtext'    
  end

  test "video DUNGA" do
		get :video, {'tag' => "dunga"} 
    assert_response :success
		assert_not_equal( 0, assigns(:entries).size, "need some VIDEO for DUNGA" )
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
