require 'test_helper'
require 'feed_validator/assertions'

class TagControllerTest < ActionController::TestCase

		test "tag cloud" do
		end

		test "twitter ajax update" do
		end

		test "twitter pagination" do
		end

		test "mrss pagination" do
		end

		test "mobile mime-type cache" do
		end
		
		test "newsletter" do
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
		assert_xml_select "entry", 1..20, "ATOM need some blog for PHN" 
	end

	test "atom blog without result" do
		get :blog, {:format => "atom", :tag => "qwerasdfpoi"}
				assert_xml_select "entry", 0, "blog need have ZERO itens for qwerasdfpoi" 
	end
	
  test "was item in atom blog without TAG" do
		get :blog, {:format => "atom"}
		assert_xml_select "entry", 1..20, "ATOM need some blog for PHN" 
  end

  test "request blog with tag" do
		get :blog, {'tag' => "phn"} 
    assert_response :success
  end

  test "was item in blog with tag dunga" do
		get :blog, {'tag' => "phn"} 
		entries = css_select("div.even")
		assert_not_equal( entries.size, 0, "need some blog for PHN" )
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
		assert_xml_select "entry", 1..20, "ATOM need some news for PHN" 
	end

	test "atom news without result" do
		get :news, {:format => "atom", :tag => "qwerasdfpoi"}
		assert_xml_select "entry", 0, "news need have ZERO itens for qwerasdfpoi" 
	end

  test "was item in atom news without TAG" do
		get :news, {:format => "atom"}
		assert_xml_select "entry", 1..20, "ATOM need some news for PHN" 
  end

  test "request news with tag" do
		get :news, {'tag' => "phn"} 
    assert_response :success
  end

  test "was item in news with tag PHN" do
		get :news, {'tag' => "phn"} 
		entries = css_select("div.even")
		assert_not_equal( entries.size, 0, "need some news for PHN" )
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
		assert_not_equal( entries.size, 0, "ATOM need some news for PHN" )
	end

	test "atom bookmark without result" do
		get :bookmark, {:format => "atom", :tag => "qwerasdfpoi"}
		entries = css_select("entry")
		assert_nil( entries[0], "news need have none itens blog for qwerasdfpoi" )
	end

  test "was item in atom bookmark without TAG" do
		get :bookmark, {:format => "atom"}
		entries = css_select("entry")
		assert_not_equal( entries.size, 0, "ATOM need some news" )
  end

  test "request bookmark with tag" do
		get :bookmark, {'tag' => "phn"} 
    assert_response :success
  end

  test "was item in bookmark with tag dunga" do
		get :bookmark, {'tag' => "dunga"} 
		entries = css_select("div.even")
		assert_not_equal( entries.size, 0, "need some bookmark for PHN" )
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
		assert_xml_select "entry", 1..20
	end

	test "atom microtext ZERO itens" do
		get :microtext, {:format => "atom", :tag => "qwerasdfpoi"}
		assert_xml_select "entry", 0, "need Zero microtext for qwerasdfpoi"
	end

  test "itens in atom microtext DEFAULT TAG" do
		get :microtext, {:format => "atom"}
		assert_xml_select "entry", 1..20
  end

  test "request microtext with tag" do
		get :microtext, {'tag' => "phn"} 
    assert_response :success
  end

  test "item in microtext with tag PHN" do
		get :microtext, {'tag' => "phn"} 
		assert_select "div.timeline div", 1..20
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
  end

	test "atom video valide" do
		get :video, {:format => "atom", :tag => "phn"}
		assert_valid_feed
	end
	
	test "atom video" do
		get :video, {:format => "atom", :tag => "phn"}
		assert_not_equal( 0, assigns(:entries).size, "ATOM need some video for PHN" )
	end

	test "atom video without result" do
		get :video, {:format => "atom", :tag => "qwerasdfpoi"}
		assert_equal( 0, assigns(:entries).size, "ATOM must have zero videos for qwerasdfpoi" )
	end


## photo

	test "photo spiritual" do
		get :photo, {'tag' => "spiritual"} 
#		assert_no_tag :tag => "div", :descendant => {:tag => "small",:attributes => { :class => "no-entrie" }} 
		assert_response :success
	end

	test "photo DUNGA" do
		get :photo, {'tag' => "dunga"} 
		assert_no_tag :tag => "div", :descendant => {:tag => "small",:attributes => { :class => "no-entrie" }} 
	end

	test "atom photo" do
		get :photo, {:format => "atom", :tag => "phn"}
		assert_not_equal( 0, assigns(:entries).size, "ATOM need some photo for PHN" )
	end

	test "atom photo without result" do
		get :photo, {:format => "atom", :tag => "qwerasdfpoi"}
		assert_equal( 0, assigns(:entries).size, "ATOM must have zero photo for qwerasdfpoi" )
	end


## index

	test "version mobile" do
		get :index, {:format => "xhtmlmp", :tag => "phn"}
	end

	test "mrss phn valid" do
		get :index, {:format => "mrss", :tag => "phn"}
		# assert_valid_feed
		assert_response :success
	end

	test "mrss phn with results" do
		get :index, {:format => "mrss", :tag => "phn"}
		assert_not_equal( 0, assigns(:entries).size, "MRSS need some item for PHN" )
	end

  test "link to spanish tag" do
		get :index, {'locale' => "es", :tag => "phn"} 
		assert_select 'div#footer a[href=?]' , "/es/phn"
  end

  test "link to english tag" do
		get :index, {'locale' => "en", :tag => "phn"} 
		assert_select 'div#footer a[href=?]' , "/en/phn"
  end

	test "title" do
		get :index, {:tag => "jonas"}
		assert_select 'title', "jonas\n    &mdash;\n    Mashup Can&ccedil;&atilde;o Nova"
	end

  test "redirect when change tag" do
		get :index, {'tag' => "oração"} 
		assert_redirected_to options = {:controller => "tag", :action => "index", :tag => "oracao"},"not redirect tag without accent"
  end

  test "redirect when change tag atom" do
		get :index, {'tag' => "oração",'format' => 'atom'} 
		assert_redirected_to options = {:controller => "tag", :action => "index", :tag => "oracao", :format => "atom"},"not redirect tag without accent or to ATOM"
  end

	test "atom index with result" do
		get :index, {:format => "atom", :tag => "phn"}
		assert_not_equal( 0, assigns(:entries).size, "ATOM need some item for PHN" )
	end
	
	test "atom index valide" do
		get :index, {:format => "atom", :tag => "phn"}
		assert_valid_feed
	end
	
	test "atom index routing" do
		get :index, {:format => "atom", :tag => "phn"}
		assert_routing "/phn.atom", { :controller => 'tag', :action => 'index', :tag => 'phn', :format => "atom"}
	end
	
	test "atom index success" do
		get :index, {:format => "atom", :tag => "phn"}
	  assert_response :success
	end

	test "index atom without result" do
		get :index, {:format => "atom", :tag => "qwerasdfpoi"}
		assert_equal( 0, assigns(:entries).size, "index ATOM must have zero for qwerasdfpoi" )
	end
	
  test "all media content" do
		get(:index, {"tag" => "phn"})
    assert_response :success
  end


# test rss link_to

	test "link to rss" do
		get :index , {"tag" => "cancaonova"}
		assert_select 'div#footer a.rss[href=?]' , "/cancaonova.rss"
	end

	test "link to rss english" do
		get :index , {"tag" => "cancaonova", :locale => "en"}
		assert_select 'div#footer a.rss[href=?]' , "/cancaonova.rss"
	end

	test "link to rss phn" do
		get :index , {"tag" => "phn"}
		assert_select 'div#footer a.rss[href=?]' , "/phn.rss"
	end

	test "link to rss blog phn" do
		get :blog , {"tag" => "phn"}
		assert_select 'div#footer a.rss[href=?]' , "/blog/phn.rss"
	end


end
