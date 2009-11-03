class MashupController < ApplicationController
	caches_page :index, :video, :photo
	
  def index
		@mashup = Mashup.all
  end

  def video
		@videos = Mashup.video
  end

  def blog
		@blogs = Mashup.blog
	end

  def photo
		@photos = Mashup.photo
  end

  def microtext
		@microtexts = Mashup.microtext
  end

  def bookmark
		@bookmarks = Mashup.bookmark
  end

	def expire
			flash[:notice] = "cache EXPIRED"
			expire_page :action => "index"
			expire_page :action => "video"
			expire_page :action => "photo"
			redirect_to :action => "index"		
	end
end
