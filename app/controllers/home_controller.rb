class HomeController < ApplicationController
	
	caches_page :index
	
  def index
			@data = Home.all
			@spotlight = Tag.all("cancaonova","rss")[0...10]
  end
		
end

