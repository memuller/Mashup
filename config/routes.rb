ActionController::Routing::Routes.draw do |map|

	map.about 			'/about',													:controller => "tag", :action => 'about'
	map.api 				'/api', 													:controller => "tag", :action => 'api'

  map.language_spanish_root '/es', 							:controller => "analytic", 	:locale => "es"
  map.language_english_root '/en', 							:controller => "analytic", 	:locale => "en"


#  map.language_spanish '/:locale/:tag', 	:controller => "tag", :requirements => {:locale => /es|en/}
  map.language_spanish '/es/:tag', 							:controller => "tag", :locale => "es"
  map.language_english '/en/:tag', 							:controller => "tag",	:locale => "en"



	map.media_tag '/:action/:tag.:format' , :controller => "tag"
	
	map.media '/:action' , :controller => "tag", :requirements => {:action => /blog|news|video|photo|microtext|bookmark|timeline|cooliris/}

	map.tag '/:tag.:format' , :controller => "tag" 

	map.root :controller => 'analytic'

end
