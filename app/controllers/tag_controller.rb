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
			unless params.include? "tag"
				@tag = ""
				return
			end
				
			tag_scan = DiacriticsFu::escape( params[:tag].clone ) #.nil? ? tag_default : params[:tag] + "+#{tag_default}"
			
			%w(++ %20).each do |var|
				tag_scan.gsub!("[#{var}]", '+')
			end

			tag_scan.gsub!(%r{&} , "+")
			tag_scan.gsub!(/([^ a-zA-Z0-9_.-\\+]+)/n,nil.to_s)
			tag_scan.gsub!(/([ ]+)/n,"+")
		
			if tag_scan != params[:tag]
				redirect_to :action => params[:index], :tag => tag_scan
			else
				@tag = tag_scan
			end
		end

	
end
