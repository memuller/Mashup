ActionController::Routing::Routes.draw do |map|

	map.about 			'/about',													:controller => "tag", :action => 'about'
	map.api 				'/api', 													:controller => "tag", :action => 'api'
	map.cooliris 	'/cooliris/:tags', 									:controller => "tag", :action => 'cooliris',	:tags => nil,		:requirements => { :tags => /.*/ }

  map.language_spanish '/es/:tags', 							:controller => "tag", :action => 'index',		:tags => nil, 	:locale => "es",		:requirements => { :tags => /.*/ }
  map.language_english '/en/:tags', 							:controller => "tag", :action => 'index',		:tags => nil, 	:locale => "en",		:requirements => { :tags => /.*/ }


	map.tag '/tag/:tag.:format' , :controller => "tag" 

	map.media_tag '/:action/tag/:tag.:format' , :controller => "tag"
	
	map.media '/blog' , :controller => "tag", :action =>  "blog" 

	map.root :controller => 'analytic'

end
