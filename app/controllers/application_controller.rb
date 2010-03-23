# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
	
  before_filter :set_tag_url, :check_format, :set_format_mobi, :set_locale_url, :set_locale, :redirect_plug4life_to_mashup, :set_tag!

	private
	
		def set_tag!
			unless params.include? "tag"
				@tag = ""
			else
				@tag = params[:tag]
			end			
		end

		def set_tag_url
	    if self.request.query_parameters.has_key? "tag"
				locale = request.query_parameters.tag
				request.query_string.gsub!(/tag=[a-z]+&/,"")
				request.query_string.gsub!(/&tag=[a-z]+/,"")
				request.query_string.gsub!(/\?tag=[a-z]+/,"")
				redirect_to "#{(params.has_key? "locale" and !self.request.query_parameters.has_key? "locale") ? "/"+params[:locale] : ""}/#{request.query_parameters.tag}?#{request.query_string}"				
			end
		end
		
		def check_format			
	    if params.has_key? "format"
				redirect_to "#{self.request.path}.#{params[:format]}"	unless self.request.path.match(/\.([a-z]{3,5})/)
				redirect_to "#{request.path.gsub(".", "+")}" unless params[:format].match(/html|xhtml|rss|mrss|iphone/)
	    end
	  end

		def set_locale
      session[:locale] = nil
      cookies.delete :locale
	    if params.has_key? "locale"
	      I18n.locale = params[:locale]
	    end
	  end

		def set_locale_url
	    if self.request.query_parameters.has_key? "locale"
				locale = request.query_parameters.locale
				request.query_string.gsub!(/locale=[a-z]{2,4}&/,"")
				request.query_string.gsub!(/&locale=[a-z]{2,4}/,"")
				request.query_string.gsub!(/\?locale=[a-z]{2,4}/,"")
				request.query_string.gsub!(/locale=[a-z]{2,4}/,"")
				redirect_to "/#{locale}#{self.request.path}?#{request.query_string}"	unless self.request.path.match(/\/(en|es)/) unless locale == I18n.default_locale				
			end
		end
		
		def set_format_mobi	
			if self.request.domain == 'cancaonova.mobi'
				params[:format] = "xhtml"
				request.headers['HTTP_ACCEPT'] = "application/xhtml+xml"
			else
				params[:format] = "html"
				request.headers['HTTP_ACCEPT'] = "text/html"
			end
		end
	  
	  def redirect_plug4life_to_mashup
	    if self.request.domain == 'plug4life.com' 
	      redirect_to 'http://mashup.cancaonova.com/', :status=>:moved_permanently
	    end
	  end

end
