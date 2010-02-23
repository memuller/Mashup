require 'test_helper'

class HomeControllerTest < ActionController::TestCase

  test "home" do
		get :index
    assert :success
	end

  test "get last tags" do
		get :index
		assert_not_nil assigns(:data)
  end

  test "lang english" do
		get :index, {'locale' => "en"} 
		assert_select 'p.slogan', "Online coverage of events in New Song"
  end

  test "lang spanish" do
		get :index, {'locale' => "es"} 
		assert_select 'p.slogan', "L&iacute;nea de cobertura de los acontecimientos en Cancion Nueva"
  end

  test "link to spanish" do
		get :index, {'locale' => "es"} 
		assert_select 'div#footer a[href=?]' , "/es"
  end

  test "link to english" do
		get :index, {'locale' => "en"} 
		assert_select 'div#footer a[href=?]' , "/en"
  end

	# test rss link_to

		test "link to rss" do
			get :index 
			assert_select 'div#footer a.rss[href=?]' , "/cancaonova.rss"
		end


end
