require 'test_helper'
require 'feed_validator/assertions'

class TagControllerTest < ActionController::TestCase

		test "add object flash video" do
		end

		test "tag cloud" do
		end

		test "version mobile" do
		end

		test "twitter ajax update" do
		end

		test "twitter pagination" do
		end

		test "mrss format to cooliris" do
		end


## timeline

	test "request timeline with tag phn" do
		get :timeline, {:tag => "phn"}
	  assert_response :success
	end

	test "request timeline without tag" do
		get :timeline
	  assert_response :success
	end


## blog

	test "valid atom blog" do
		get :blog, {:format => "atom", :tag => "phn"}
		assert_valid_feed
	end
	test "routing atom blog" do
		get :blog, {:format => "atom", :tag => "phn"}
		assert_routing "/blog/phn.atom", { :controller => 'tag', :action => 'blog', :tag => 'phn', :format => "atom"}
	end
	test "response atom blog" do
		get :blog, {:format => "atom", :tag => "phn"}
	  assert_response :success
	end

	test "was item atom blog" do
		get :blog, {:format => "atom", :tag => "phn"}
		itens = css_select("div.even")
		assert_not_nil( itens, "ATOM need some blog for PHN" )
	end

	test "atom blog without result" do
		get :blog, {:format => "atom", :tag => "qwerasdfpoi"}
		entries = css_select("entry")
		assert_not_nil( entries, "blog need have ZERO itens for qwerasdfpoi" )
	end
	
  test "was item in atom blog without TAG" do
		get :blog, {:format => "atom"}
		entries = css_select("entry")
		assert_not_nil( entries, "ATOM need some blog for PHN" )
  end

  test "request blog with tag" do
		get :blog, {'tag' => "phn"} 
    assert_response :success
  end

  test "was item in blog with tag dunga" do
		get :blog, {'tag' => "phn"} 
		entries = css_select("div.even")
		assert_not_nil( entries, "need some blog for PHN" )
  end

  test "only blog without tag" do
		get :blog
    assert_response :success
  end
		

## news

	test "valid atom news" do
		get :news, {:format => "atom", :tag => "phn"}
		assert_valid_feed
	end
	test "routing atom news" do
		get :news, {:format => "atom", :tag => "phn"}
		assert_routing "/news/phn.atom", { :controller => 'tag', :action => 'news', :tag => 'phn', :format => "atom"}
	end
	test "response atom news" do
		get :news, {:format => "atom", :tag => "phn"}
	  assert_response :success
	end

	test "was item atom news" do
		get :news, {:format => "atom", :tag => "phn"}
		itens = css_select("div.even")
		assert_not_nil( itens, "ATOM need some news for PHN" )
	end

	test "atom news without result" do
		get :news, {:format => "atom", :tag => "qwerasdfpoi"}
		entries = css_select("entry")
		assert_nil( entries, "news need have none itens for qwerasdfpoi" )
	end

  test "was item in atom news without TAG" do
		get :news, {:format => "atom"}
		entries = css_select("entry")
		assert_not_nil( entries, "ATOM need some news for PHN" )
  end

  test "request news with tag" do
		get :news, {'tag' => "phn"} 
    assert_response :success
  end

  test "was item in news with tag PHN" do
		get :news, {'tag' => "phn"} 
		entries = css_select("div.even")
		assert_not_nil( entries, "need some news for PHN" )
  end

  test "only news without tag" do
		get :news
    assert_response :success
  end


## bookmark

	test "valid atom bookmark" do
		get :bookmark, {:format => "atom", :tag => "phn"}
		assert_valid_feed
	end
	test "routing atom bookmark" do
		get :bookmark, {:format => "atom", :tag => "phn"}
		assert_routing "/bookmark/phn.atom", { :controller => 'tag', :action => 'bookmark', :tag => 'phn', :format => "atom"}
	end
	test "response atom bookmark" do
		get :bookmark, {:format => "atom", :tag => "phn"}
	  assert_response :success
	end

	test "was item atom bookmark for PHN" do
		get :bookmark, {:format => "atom", :tag => "phn"}
		entries = css_select("entry")
		assert_not_nil( entries, "ATOM need some news for PHN" )
	end

	test "atom bookmark without result" do
		get :bookmark, {:format => "atom", :tag => "qwerasdfpoi"}
		entries = css_select("entry")
		assert_nil( entries, "news need have none itens blog for qwerasdfpoi" )
	end

  test "was item in atom bookmark without TAG" do
		get :bookmark, {:format => "atom"}
		entries = css_select("entry")
		assert_not_nil( entries.size, "ATOM need some news" )
  end

  test "request bookmark with tag" do
		get :bookmark, {'tag' => "phn"} 
    assert_response :success
  end

  test "was item in bookmark with tag dunga" do
		get :bookmark, {'tag' => "dunga"} 
		entries = css_select("div.even")
		assert_not_nil( entries.size, "need some bookmark for PHN" )
  end

  test "only bookmark without tag" do
		get :bookmark
    assert_response :success
  end

## microtext

	test "valid atom microtext" do
		get :microtext, {:format => "atom", :tag => "phn"}
		assert_valid_feed
	end
	
	test "routing atom microtext" do
		get :microtext, {:format => "atom", :tag => "phn"}
		assert_routing "/microtext/phn.atom", { :controller => 'tag', :action => 'microtext', :tag => 'phn', :format => "atom"}
	end
	
	test "response atom microtext" do
		get :microtext, {:format => "atom", :tag => "phn"}
	  assert_response :success
	end

	test "item atom microtext for PHN" do
		get :microtext, {:format => "atom", :tag => "phn"}
		assert_select "entry", 1..10, "ATOM need some microtext for PHN"
	end

	test "atom microtext ZERO itens" do
		get :microtext, {:format => "atom", :tag => "qwerasdfpoi"}
		assert_select "entry", 0, "need Zero microtext for qwerasdfpoi"
	end

  test "itens in atom microtext DEFAULT TAG" do
		get :microtext, {:format => "atom"}
		assert_select "entry", 1..10, "need some microtext for PHN"
  end

  test "request microtext with tag" do
		get :microtext, {'tag' => "phn"} 
    assert_response :success
  end

  test "item in microtext with tag PHN" do
		get :microtext, {'tag' => "phn"} 
		assert_select "div.timeline div", 1..10, "need some microtext for PHN"
  end

  test "microtext default tag" do
		get :microtext
    assert_response :success
  end

  test "duplicate microtext with phn" do
		get :microtext, {'tag' => "phn"} 
		row_even = css_select("div.even")
		row_odd = css_select("div.odd")
		assert_not_equal( row_even[0], row_odd[0], "ATOM need some news for PHN" )
  end


## video

  test "video DUNGA" do
		get :video, {'tag' => "dunga"} 
		assert_not_equal( 0, assigns(:entries).size, "need some VIDEO for DUNGA" )
		assert_template 'tag/video'    
    assert_response :success
  end

	test "atom video" do
		get :video, {:format => "atom", :tag => "phn"}
		assert_valid_feed
		assert_not_equal( 0, assigns(:entries).size, "ATOM need some video for PHN" )
		assert_routing "/video/phn.atom", { :controller => 'tag', :action => 'video', :tag => 'phn', :format => "atom"}
	  assert_response :success
	end

	test "atom video without result" do
		get :video, {:format => "atom", :tag => "qwerasdfpoi"}
		assert_valid_feed
		assert_equal( 0, assigns(:entries).size, "ATOM must have zero videos for qwerasdfpoi" )
		assert_routing "/video/qwerasdfpoi.atom", { :controller => 'tag', :action => 'video', :tag => 'qwerasdfpoi', :format => "atom"}
	  assert_response :success
	end


## photo

  test "photo DUNGA" do
		get :photo, {'tag' => "dunga"} 
		assert_no_tag :tag => "div", :descendant => {:tag => "small",:attributes => { :class => "no-entrie" }} 
		assert_template 'tag/photo'    
    assert_response :success
  end

	test "atom photo" do
		get :photo, {:format => "atom", :tag => "phn"}
		assert_valid_feed
		assert_not_equal( 0, assigns(:entries).size, "ATOM need some photo for PHN" )
		assert_routing "/photo/phn.atom", { :controller => 'tag', :action => 'photo', :tag => 'phn', :format => "atom"}
	  assert_response :success
	end

	test "atom photo without result" do
		get :photo, {:format => "atom", :tag => "qwerasdfpoi"}
		assert_valid_feed
		assert_equal( 0, assigns(:entries).size, "ATOM must have zero photo for qwerasdfpoi" )
		assert_routing "/photo/qwerasdfpoi.atom", { :controller => 'tag', :action => 'photo', :tag => 'qwerasdfpoi', :format => "atom"}
	  assert_response :success
	end


## index

  test "redirect when change tag" do
		get :index, {'tag' => "oração"} 
		assert_redirected_to options = {:controller => "tag", :action => "index", :tag => "oracao"},"not redirect tag without accent"
  end

  test "redirect when change tag atom" do
		get :index, {'tag' => "oração",'format' => 'atom'} 
		assert_redirected_to options = {:controller => "tag", :action => "index", :tag => "oracao", :format => "atom"},"not redirect tag without accent or to ATOM"
  end

	test "atom index" do
		get :index, {:format => "atom", :tag => "phn"}
		assert_valid_feed
		assert_not_equal( 0, assigns(:entries).size, "ATOM need some item for PHN" )
		assert_routing "/phn.atom", { :controller => 'tag', :action => 'index', :tag => 'phn', :format => "atom"}
	  assert_response :success
	end

	test "index atom without result" do
		get :index, {:format => "atom", :tag => "qwerasdfpoi"}
		assert_valid_feed
		assert_equal( 0, assigns(:entries).size, "index ATOM must have zero for qwerasdfpoi" )
		assert_routing "/qwerasdfpoi.atom", { :controller => 'tag', :action => 'index', :tag => 'qwerasdfpoi', :format => "atom"}
	  assert_response :success
	end
  test "all media content" do
		get(:index, {"tag" => "phn"})
    assert_response :success
  end

end
