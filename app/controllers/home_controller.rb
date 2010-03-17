class HomeController < ApplicationController
	
	caches_page :index, :expires_in => 5.minutes
	
  def index
			@data = Home.all
			@spotlight = Tag.all_rss("cancaonova")[0...10]
  end
		
end

