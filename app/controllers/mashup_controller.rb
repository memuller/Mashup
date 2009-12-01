class MashupController < ApplicationController
	caches_page :index, :video, :photo
	
  def index
		tag = params[:tag].nil? ?  nil.to_s : params[:tag]		 
		@mashup = Mashup.all(tag)
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

  def timeline
		@mashup = Mashup.timeline
  end

	def expire
			flash[:notice] = "cache EXPIRED"
			expire_page :action => "index"
			expire_page :action => "video"
			expire_page :action => "photo"
			redirect_to :action => "index"		
	end
end
