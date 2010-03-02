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
		get :timeline, :tag => "phn"
	  assert_response :success
	end

	test "request timeline without tag" do
		get :timeline
	  assert_response :success
	end


## blog

	test "valid rss blog" do
		get :blog, :format => "rss", :tag => "phn"
		assert_valid_feed
	end
	test "routing rss blog" do
		get :blog, :format => "rss", :tag => "phn"
		assert_routing "/blog/phn.rss", { :controller => 'tag', :action => 'blog', :tag => 'phn', :format => "rss"}
	end
	test "response rss blog" do
		get :blog, :format => "rss", :tag => "phn"
	  assert_response :success
	end

	test "was item rss blog" do
		get :blog, :format => "rss", :tag => "phn"
		assert_xml_select "entry", 1..20, "ATOM need some blog for PHN" 
	end

	test "rss blog without result" do
		get :blog, :format => "rss", :tag => "qwerasdfpoi"
				assert_xml_select "entry", 0, "blog need have ZERO itens for qwerasdfpoi" 
	end
	
  test "was item in rss blog without TAG" do
		get :blog, :format => "rss", :tag => "cancaonova"
		assert_xml_select "entry", 1..20, "ATOM need some blog for PHN" 
  end

  test "request blog with tag" do
		get :blog, 'tag' => "phn"
    assert_response :success
  end

  test "was item in blog with tag dunga" do
		get :blog, 'tag' => "phn" 
		entries = css_select("div.even")
		assert_not_equal( entries.size, 0, "need some blog for PHN" )
  end

  test "only blog without tag" do
		get :blog
    assert_response :success
  end
		

## news

	test "valid rss news" do
		get :news, :format => "rss", :tag => "phn"
		assert_valid_feed
	end
	test "routing rss news" do
		get :news, :format => "rss", :tag => "phn"
		assert_routing "/news/phn.rss", { :controller => 'tag', :action => 'news', :tag => 'phn', :format => "rss"}
	end
	test "response rss news" do
		get :news, :format => "rss", :tag => "phn"
	  assert_response :success
	end

	test "was item rss news" do
		get :news, :format => "rss", :tag => "phn"
		assert_xml_select "entry", 1..20, "ATOM need some news for PHN" 
	end

	test "rss news without result" do
		get :news, :format => "rss", :tag => "qwerasdfpoi"
		assert_xml_select "entry", 0, "news need have ZERO itens for qwerasdfpoi" 
	end

  test "was item in rss news without TAG" do
		get :news, :format => "rss",:tag => "phn"
		assert_xml_select "entry", 1..20, "ATOM need some news for PHN" 
  end

  test "request news with tag" do
		get :news, 'tag' => "phn"
    assert_response :success
  end

  test "was item in news with tag PHN" do
		get :news, 'tag' => "phn"
		entries = css_select("div.even")
		assert_not_equal( entries.size, 0, "need some news for PHN" )
  end

  test "only news without tag" do
		get :news
    assert_response :success
  end


## bookmark

	test "valid rss bookmark" do
		get :bookmark, :format => "rss", :tag => "phn"
		assert_valid_feed
	end
	test "routing rss bookmark" do
		get :bookmark, :format => "rss", :tag => "phn"
		assert_routing "/bookmark/phn.rss", { :controller => 'tag', :action => 'bookmark', :tag => 'phn', :format => "rss"}
	end
	test "response rss bookmark" do
		get :bookmark, {:format => "rss", :tag => "phn"}
	  assert_response :success
	end

	test "was item rss bookmark for PHN" do
		get :bookmark, :format => "rss", :tag => "phn"
		entries = css_select("entry")
		assert_not_equal( entries.size, 0, "ATOM need some news for PHN" )
	end

	test "rss bookmark without result" do
		get :bookmark, :format => "rss", :tag => "qwerasdfpoi"
		entries = css_select("entry")
		assert_nil( entries[0], "news need have none itens blog for qwerasdfpoi" )
	end

	test "was item in rss bookmark without TAG" do
		get :bookmark, :format => "rss", :tag => "cancaonova"
		entries = css_select("entry")
		assert_not_equal( entries.size, 0, "ATOM need some news" )
  end

  test "request bookmark with tag" do
		get :bookmark, 'tag' => "phn"
    assert_response :success
  end

  test "was item in bookmark with tag dunga" do
		get :bookmark, 'tag' => "dunga"
		entries = css_select("div.even")
		assert_not_equal( entries.size, 0, "need some bookmark for PHN" )
  end

  test "only bookmark without tag" do
		get :bookmark
    assert_response :success
  end

## microblog

	test "valid rss microblog" do
		get :microblog, :format => "rss", :tag => "phn"
		assert_valid_feed
	end
	
	test "routing rss microblog" do
		get :microblog, :format => "rss", :tag => "phn"
		assert_routing "/microblog/phn.rss", { :controller => 'tag', :action => 'microblog', :tag => 'phn', :format => "rss"}
	end
	
	test "response rss microblog" do
		get :microblog, :format => "rss", :tag => "phn"
	  assert_response :success
		assert_xml_select "entry", 1..20
	end

	test "rss microblog ZERO itens" do
		get :microblog, :format => "rss", :tag => "qwerasdfpoi"
		assert_xml_select "entry", 0, "need Zero microblog for qwerasdfpoi"
	end

  test "itens in rss microblog DEFAULT TAG" do
		get :microblog, :format => "rss", :tag => "cancaonova"
		assert_xml_select "entry", 1..20
  end

  test "request microblog with tag" do
		get :microblog, 'tag' => "phn"
    assert_response :success
  end

  test "item in microblog with tag PHN" do
		get :microblog, 'tag' => "phn" 
		assert_select "div.timeline div", 1..20
  end

  test "microblog default tag" do
		get :microblog
    assert_response :success
  end

  test "duplicate microblog with phn" do
		get :microblog, 'tag' => "phn" 
		row_even = css_select("div.even")
		row_odd = css_select("div.odd")
		assert_not_equal( row_even[0], row_odd[0], "ATOM need some news for PHN" )
  end


## video

  test "video DUNGA" do
		get :video, 'tag' => "dunga"
		assert_not_equal( 0, assigns(:entries).size, "need some VIDEO for DUNGA" )
  end

	test "rss video valide" do
		get :video, :format => "rss", :tag => "phn"
		assert_valid_feed
	end
	
	test "rss video" do
		get :video, :format => "rss", :tag => "phn"
		assert_not_equal( 0, assigns(:entries).size, "ATOM need some video for PHN" )
	end

	test "rss video without result" do
		get :video, :format => "rss", :tag => "qwerasdfpoi"
		assert_equal( 0, assigns(:entries).size, "ATOM must have zero videos for qwerasdfpoi" )
	end


## photo

	test "photo spiritual" do
		get :photo, 'tag' => "spiritual"
#		assert_no_tag :tag => "div", :descendant => {:tag => "small",:attributes => { :class => "no-entrie" }} 
		assert_response :success
	end

	test "photo DUNGA" do
		get :photo, 'tag' => "dunga"
		assert_no_tag :tag => "div", :descendant => {:tag => "small",:attributes => { :class => "no-entrie" }} 
	end

	test "rss photo" do
		get :photo, :format => "rss", :tag => "phn"
		assert_not_equal( 0, assigns(:entries).size, "ATOM need some photo for PHN" )
	end

	test "rss photo without result" do
		get :photo, :format => "rss", :tag => "qwerasdfpoi"
		assert_equal( 0, assigns(:entries).size, "ATOM must have zero photo for qwerasdfpoi" )
	end


## cooliris

	test "version cooliris" do
		get :cooliris
		assert_equal "cancaonova", assigns(:tag)
	end

## index

	test "version mobile" do
		get :index, :format => "xhtml", :tag => "phn"
		assert_response :success
	end

	test "mrss phn valid" do
		get :index, :format => "mrss", :tag => "phn"
		# assert_valid_feed # can't validate, because not insert OPTIONAL element of mrss
		assert_response :success
		assert_not_equal( 0, assigns(:entries).size, "MRSS need some item for PHN" )
	end

  test "should link to tag phn in spanish" do
		get :index, 'locale' => "es", :tag => "phn"
		assert_select 'div#footer a[href=?]' , "/es/phn"
  end

  test "should link to tag phn in english" do
		get :index, 'locale' => "en", :tag => "phn"
		assert_select 'div#footer a[href=?]' , "/en/phn"
  end

	test "title" do
		get :index, :tag => "jonas"
		assert_select 'title', "jonas\n    &mdash;\n    Mashup Can&ccedil;&atilde;o Nova"
	end

  test "redirect when change tag" do
		get :index, 'tag' => "oração"
		assert_redirected_to options = {:controller => "tag", :action => "index", :tag => "oracao"},"not redirect tag without accent"
  end

  test "redirect when change tag rss" do
		get :index, 'tag' => "oração",'format' => 'rss'
		assert_redirected_to options = {:controller => "tag", :action => "index", :tag => "oracao", :format => "rss"},"not redirect tag without accent or to ATOM"
  end

	test "rss index with result" do
		get :index, :format => "rss", :tag => "phn"
		assert_not_equal( 0, assigns(:entries).size, "ATOM need some item for PHN" )
	end
	
	test "rss index valide" do
		get :index, :format => "rss", :tag => "phn"
		assert_valid_feed
	end
	
	test "rss index routing" do
		get :index, :format => "rss", :tag => "phn"
		assert_routing "/phn.rss", { :controller => 'tag', :action => 'index', :tag => 'phn', :format => "rss"}
	end
	
	test "rss index success" do
		get :index, :format => "rss", :tag => "phn"
	  assert_response :success
	end

	test "index rss without result" do
		get :index, :format => "rss", :tag => "qwerasdfpoi"
		assert_equal( 0, assigns(:entries).size, "index ATOM must have zero for qwerasdfpoi" )
	end
	
  test "all media content" do
		get :index, "tag" => "phn"
    assert_response :success
  end


# test rss link_to

	test "link to rss" do
		get :index , "tag" => "cancaonova"
		assert_select 'div#footer a.rss[href=?]' , "/cancaonova.rss"
	end

	test "link to rss english" do
		get :index , "tag" => "cancaonova", :locale => "en"
		assert_select 'div#footer a.rss[href=?]' , "/cancaonova.rss"
	end

	test "link to rss phn" do
		get :index , "tag" => "phn"
		assert_select 'div#footer a.rss[href=?]' , "/phn.rss"
	end

	test "link to rss blog phn" do
		get :blog , "tag" => "phn"
		assert_select 'div#footer a.rss[href=?]' , "/blog/phn.rss"
	end

# iphone

	test "should render timeline template to iphone" do
		get :timeline , :format => "iphone"
		assert_template "tag/timeline.iphone.haml"
	end

	test "should render microblog template to iphone" do
		get :microblog , :format => "iphone"
		assert_template "tag/microblog.iphone.haml"
	end

end
