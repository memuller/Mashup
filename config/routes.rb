ActionController::Routing::Routes.draw do |map|

	map.about 			'/about',	:controller => "tag", :action => 'about'
	map.api 				'/api', 	:controller => "tag", :action => 'api'

  map.language '/:locale', :controller => "home", :requirements => {:locale => /es|en/} 
  map.language '/:locale/:tag.:format', :controller => "tag", :requirements => {:locale => /es|en/}

	#pagination
	map.media_tag_paginate '/:action/:tag/pagina/:page.:format' , 	:controller => "tag", :requirements => {:action => /blog|news|video|photo|microblog|bookmark|timeline|cooliris/}

	map.media_paginate '/:action/pagina/:page.:format' , 	:controller => "tag", :requirements => {:action => /blog|news|video|photo|microblog|bookmark|timeline|cooliris/}

	map.media '/:action/:tag.:format' , :tag => nil, 	:controller => "tag", :requirements => {:action => /blog|news|video|photo|microblog|bookmark|timeline|cooliris/}
	map.tag '/:tag.:format' , :controller => "tag", :requirements => { :tag => /[\w]+(?=\.[html|xhtml|rss|mrss|])|.+/ } 
	map.media_tag '/:action/tag/:tag.:format' , :tag => nil, 	:controller => "tag", :requirements => {:action => /blog|news|video|photo|microblog|bookmark|timeline|cooliris/,  :tag => /[\w]+(?=\.(html|xhtml|rss|mrss))|[\w\.]+/ }

  map.search '/:controller/:action.:format', :controller => "home", :tag => nil, :requirements => {:action => /search/} 

	map.root :controller => 'home'

end