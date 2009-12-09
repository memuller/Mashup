class TagController < ApplicationController
	
	caches_page :index, :video, :photo
	before_filter :set_tag
	attr_reader :content

  def index
		@content = Tag.all(@tag)
  end

  def video
		@content = Tag.video
  end

  def blog
		@content = Tag.blog(@tag)
	end

  def photo
		@content = Tag.photo
  end

  def microtext
		@content = Tag.microtext
  end

  def bookmark
		@content = Tag.bookmark
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
			tag_default = "cancaonova"
			@tag = params[:tag].nil? ? tag_default : params[:tag].concat("+#{tag_default}")
		end

	
end
