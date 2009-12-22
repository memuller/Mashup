class TagController < ApplicationController
	
	caches_page :index, :video, :photo, :blog
	before_filter :set_tag
	attr_reader :content

  def index
		@content = Tag.all(@tag)
  end

  def video
		@content = Tag.video(@tag)
  end

  def blog
		@content = Tag.blog(@tag)
	end

  def photo
		@content = Tag.photo(@tag)
  end

  def microtext
		@content = Tag.microtext(@tag)
  end

  def bookmark
		@content = Tag.bookmark(@tag)
  end

  def timeline
		@content = Tag.timeline
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
