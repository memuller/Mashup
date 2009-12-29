ActionController::Routing::Routes.draw do |map|

	map.tag '/tag/:tag.:format' , :controller => "tag" 

	map.media_tag '/:action/tag/:tag.:format' , :controller => "tag"
	
	map.media '/blog' , :controller => "tag", :action =>  "blog" 

	map.root :controller => 'analytic'

end
