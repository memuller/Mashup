class TagController < ApplicationController
	
	caches_page :index, :video, :photo, :blog
	before_filter :set_tag
	attr_reader :content

  def index
		@entries = Tag.all(@tag)
		@entries
  end

  def video
		@entries = Tag.video(@tag)
  end

  def blog
		@entries = Tag.blog(@tag)
	end

  def photo
		@entries = Tag.photo(@tag)
  end

  def microtext
		@entries = Tag.microtext(@tag)
  end

  def bookmark
		@entries = Tag.bookmark(@tag)
  end

  def timeline
		@entries = Tag.timeline
  end

	protected	

		def expire
				flash[:notice] = "cache EXPIRED"
				expire_page :action => "index"
				expire_page :action => "video"
				expire_page :action => "photo"
				redirect_to :action => "index"		
		end
	
		def set_tag
#			tag_default = "cancaonova"
			@tag = params[:tag]#.nil? ? tag_default : params[:tag] + "+#{tag_default}"
		end

	
end
