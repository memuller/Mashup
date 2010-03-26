ActionController::Routing::Routes.draw do |map|

	map.about 			'/about',	:controller => "tag", :action => 'about'
	map.api 				'/api', 	:controller => "tag", :action => 'api'

  map.language '/:locale', :controller => "home", :requirements => {:locale => /es|en/} 
  map.language '/:locale/:tag', :controller => "tag", :requirements => {:locale => /es|en/}

	map.media '/:action/:tag.:format' , :tag => nil, 	:controller => "tag", :requirements => {:action => /blog|news|video|photo|microblog|bookmark|timeline|cooliris/}
	map.tag '/:tag.:format' , :controller => "tag", :requirements => { :tag => /.+(?=\.(html|xhtml|rss|mrss))|.+/ } 

	map.media_tag '/:action/tag/:tag.:format' , :tag => nil, 	:controller => "tag", :requirements => {:action => /blog|news|video|photo|microblog|bookmark|timeline|cooliris/,  :tag => /.+(?=\.(html|xhtml|rss|mrss))|.+/ }

  map.search '/:controller/:action.:format', :controller => "home", :tag => nil, :requirements => {:action => /search/} 

	map.root :controller => 'home'

end