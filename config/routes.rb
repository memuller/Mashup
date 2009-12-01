ActionController::Routing::Routes.draw do |map|

	map.tag '/:tag' , :controller => "mashup" , :action => "index" 
	map.tag '/:tag' , :controller => "mashup" , :action => "index" 

	map.root :controller => 'analytic', :action => "index"

end
