class TagController < ApplicationController
	
	attr_reader :entries
	before_filter :clear_tag
	caches_page :index, :video, :blog, :news, :photo, :microtext, :bookmark, :timeline  

  def index
		respond_to do |format|
				format.xhtml 	{ @entries = Tag.all(@tag) }
		    format.rss		{ @entries = Tag.all_rss(@tag) }
		    format.mrss		{ @entries = Tag.all_mrss(@tag) }		
	    	format.any		{ 
												params[:format] = "html"
												@entries = Tag.all(@tag) 
											}
		  end
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
		respond_to do |format|
		    format.html		{ @entries = Tag.timeline(@tag) }
				format.xhtml	{ @entries = Tag.timeline(@tag) }
		    format.rss		{ redirect_to :controller => "tag", :tag=> params[:tag], :format => "rss" }
		  end
  end

  def cooliris
		@tag = Tag.default_tag("").gsub("+","").gsub(",","") if @tag.empty? 
		respond_to do |format|
		    format.html		{ @entries = Tag.timeline(@tag) }
				format.xhtml	{ @entries = Tag.timeline(@tag) }
		    format.rss		{ redirect_to :controller => "tag", :tag=> params[:tag], :format => "rss" }
		  end
  end

  def about
		render_public "sobre-o-mashup"
  end

  def api
		render_public "api-mashup"
  end

	def render_public file_name
    render :file => "#{RAILS_ROOT}/public/#{file_name}.htm"		, :content_type => 'text/html', :layout => true		
	end
	
	protected	
	
		def clear_tag
			return if @tag.empty?
	
			@tag = DiacriticsFu::escape( @tag )

			%w("[++]" "[%20]" \s %r{&}).each do |var|
				@tag.gsub!(var, '+')
			end

			@tag.gsub!(/([^ a-zA-Z0-9_\.-\\+]+)/n,nil.to_s)
			@tag.gsub!(/[^\w+\.]/,nil.to_s)
			if @tag != params[:tag]
				redirect_to :action => params[:index], :tag => @tag, :format => (params[:format] != "html") ? params[:format] : nil	
			end
		end

end

