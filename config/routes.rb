ActionController::Routing::Routes.draw do |map|

	map.about 			'/about',	:controller => "tag", :action => 'about'
	map.api 				'/api', 	:controller => "tag", :action => 'api'

  map.language '/:locale', :controller => "home", :tag => nil, :requirements => {:locale => /es|en|pt-BR/} 
  map.language '/:locale/:tag', :controller => "tag", :requirements => {:locale => /es|en|pt-BR/}

	map.media '/:action/:tag.:format' , :tag => nil, 	:controller => "tag", :requirements => {:action => /blog|news|video|photo|microblog|bookmark|timeline|cooliris/}
	map.tag '/:tag.:format' , :controller => "tag" 

	map.root :controller => 'home'

end
