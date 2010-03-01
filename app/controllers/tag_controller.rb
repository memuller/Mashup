class TagController < ApplicationController
	
	attr_reader :entries
	before_filter :set_tag
	caches_page :index, :video, :blog, :news, :photo, :microtext, :bookmark, :timeline  

  def index
		@entries = Tag.all(@tag, params[:format])
  end

  def video
		@entries = Tag.video(@tag)
  end

  def blog
		@entries = Tag.blog(@tag)
	end

  def news
		@entries = Tag.news(@tag)
	end

  def photo
		@entries = Tag.photo(@tag)
  end

  def microblog
		@entries = Tag.microblog(@tag)
  end

  def bookmark
		@entries = Tag.bookmark(@tag)
  end

  def timeline
		@entries = Tag.timeline(@tag)
  end

  def cooliris
		@tag = Tag.default_tag("").gsub("+","") if @tag.empty? 
  end

	protected	

		def set_tag
			unless params.include? "tag"
				@tag = ""
				return
			end

			@tag = DiacriticsFu::escape( params[:tag] )

			%w("[++]" "[%20]" \s %r{&}).each do |var|
				@tag.gsub!(var, '+')
			end

			@tag.gsub!(/([^ a-zA-Z0-9_.-\\+]+)/n,nil.to_s)
			if @tag != params[:tag]
				redirect_to :action => params[:index], :tag => @tag, :format => params[:format] 	
			end
		end

end
