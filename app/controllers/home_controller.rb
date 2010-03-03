class HomeController < ApplicationController
	
	caches_page :index
	
  def index
			@tag = (params[:tag].nil?) ? "" : params[:tag] 
			@data = Home.all
			@spotlight = Tag.all("cancaonova","rss")[0...10]
  end

end

