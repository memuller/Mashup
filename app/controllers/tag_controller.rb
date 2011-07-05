class TagController < ApplicationController
	
	attr_reader :entries
	before_filter :remove_tag_static, :clear_tag, :redirect_rss_to_feedburner, :event_page
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
		@entries = Tag.video(@tag, @page)
  end

  def blog
		@entries = Tag.blog(@tag, @page)
	end

  def news
		@entries = Tag.news(@tag)
	end

  def photo
		@entries = Tag.photo(@tag)
  end

  def microblog
		@entries = Tag.microblog(@tag, @page)
  end

  def bookmark
		@entries = Tag.bookmark(@tag, @page)
  end

  def timeline
		respond_to do |format|
		    format.html		{ @entries = Tag.timeline(@tag) }
				format.xhtml	{ @entries = Tag.timeline(@tag) }
		    format.rss		{ redirect_to :controller => "tag", :tag=> params[:tag], :format => "rss" }
		  end
  end

  def cooliris
#		@tag = Tag.default_tag("").gsub("+","").gsub(",","") if @tag.empty? 
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
			Array.[](/\+\+/, /%20/, /\./, /\s/, /%r{&}/).each do |var|
				@tag.gsub!(var, '+')
			end

#			@tag.gsub!(/[^\w\d\+]|([^\.-\\]+)/n,"+")#nil.to_s)
			@tag.gsub!(/([^ a-zA-Z0-9_\.-\\+]+)/n,"+")#nil.to_s)
			@tag.gsub!(/[\+]$/,nil.to_s)
			@tag.downcase!
			if @tag != params[:tag]
					redirect_to :action => params[:action], :tag => @tag, :format =>( (params[:format] != "html") ? params[:format] : nil), :locale => (I18n.locale != I18n.default_locale) ? I18n.locale	: nil					
			end
		end

		def redirect_rss_to_feedburner
			if params[:format] == "rss" and params[:action] == "index"   
				if params[:tag].nil? or params[:tag] == "cancaonova"
						redirect_to 'http://feeds.feedburner.com/mashupcancaonova', :status=>:moved_permanently unless request.headers['User-Agent'].match(/FeedBurner/)
				end	
			end
		end

		def remove_tag_static
			if request.path.include? "/tag/" or request.path.include? "/tag%2F"
				redirect_to request.path.gsub(/\/tag\//,"/").gsub(/\/tag%2F/,"/") 
			end
		end
end

