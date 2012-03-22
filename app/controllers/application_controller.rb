# -*- encoding : utf-8 -*-
# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
	
  before_filter :set_tag_url, :check_format, :set_format_mobi, :set_locale_url, :set_locale, :redirect_plug4life_to_mashup, :set_tag!, :set_page!

	private
		
		def event_page
			event_name = 'muticom'
			if @tag.include? event_name
				@event = event_name
			end
		end
			
		def set_tag!
			unless params.include? "tag"
				@tag = ""
			else
				@tag = params[:tag]
			end			
		end

		def set_page!
			@page = 1
			@page = params[:page] if params.include? "page"
		end

		def set_tag_url
	    if self.request.query_parameters.has_key? "tag"
				locale = request.query_parameters.tag
				remove_query_string! Array.[](/tag=[\w]+/, /tag=[\w]+&/, /&tag=[\w]+/, /\?tag=[\w]+/)
				_locale = "/"+I18n.locale unless I18n.locale == I18n.default_locale
#				redirect_to "#{_locale}/#{request.query_parameters.tag}?#{request.query_string}"				
				redirect_to :action => params[:action], :tag => @tag, :format =>( (params[:format] != "html") ? params[:format] : nil), :locale => (I18n.locale != I18n.default_locale) ? I18n.locale	: nil					
			end
		end
		
		def check_format			
	    if params.has_key? "format"
				redirect_path = self.request.path
				redirect_path = "#{redirect_path}.#{params[:format]}"	unless redirect_path.match(/\.([a-z]{3,6})/)
				redirect_path = redirect_path.gsub(".", "+") unless params[:format].match(/html|xhtml|rss|mrss|iphone/)
				redirect_to redirect_path if self.request.path != redirect_path
	    end
	  end

		def set_locale			
      session[:locale] = nil
      cookies.delete :locale
	    if params.has_key? "locale"
	      I18n.locale = params[:locale]
	    end
      I18n.locale = I18n.default_locale
	  end
		
		def set_locale_url
	    if self.request.query_parameters.has_key? "locale"
				locale = request.query_parameters.locale				
				remove_query_string! Array.[](/locale=[a-z]{2,4}&/, /&locale=[a-z]{2,4}/, /\?locale=[a-z]{2,4}/, /locale=[a-z]{2,4}/)			
#				redirect_to "/#{locale}#{self.request.path}?#{request.query_string}"	unless self.request.path.match(/\/(en|es)/) 	unless locale == I18n.default_locale
				redirect_to :action => params[:action], :tag => @tag, :format =>( (params[:format] != "html") ? params[:format] : nil), :locale => (I18n.locale != I18n.default_locale) ? I18n.locale	: nil					
			end
		end
		
		def set_format_mobi	
			if self.request.domain == 'cancaonova.mobi'
				params[:format] = "xhtml"
				request.headers['HTTP_ACCEPT'] = "application/xhtml+xml"
			else
				unless params.has_key? "format"
					params[:format] = "html" 
					request.headers['HTTP_ACCEPT'] = "text/html"
				end
			end
		end
	  
	  def redirect_plug4life_to_mashup
	    if self.request.domain == 'plug4life.com' 
	      redirect_to 'http://mashup.cancaonova.com/', :status=>:moved_permanently
	    end
	  end

		def remove_query_string! remove
			remove.each do |var|
				self.request.query_string.gsub!(var, '')
			end			
		end
		
end
