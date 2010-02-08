ActionController::Routing::Routes.draw do |map|

	map.about 			'/about',													:controller => "tag", :action => 'about'
	map.api 				'/api', 													:controller => "tag", :action => 'api'
	map.cooliris 	'/cooliris/:tag', 									:controller => "tag", :action => 'cooliris',	:tag => nil,		:requirements => { :tag => /.*/ }

  map.language_spanish_root '/es', 							:controller => "analytic", 	:locale => "es"
  map.language_english_root '/en', 							:controller => "analytic", 	:locale => "en"

  map.language_spanish '/es/:tag', 							:controller => "tag", :locale => "es"
  map.language_english '/en/:tag', 							:controller => "tag",	:locale => "en"



	map.media_tag '/:action/:tag.:format' , :controller => "tag"
	
	map.media '/blog' , :controller => "tag", :action =>  "blog" 

	map.tag '/:tag.:format' , :controller => "tag" 

	map.root :controller => 'analytic'

end
