class HomeController < ApplicationController
	
	caches_page :index
	
  def index
			@tag = (params[:tag].nil?) ? "" : params[:tag] 
			@data = Home.all
#			@spotlight = Tag.all("cancaonova","mrss")
  end

end

