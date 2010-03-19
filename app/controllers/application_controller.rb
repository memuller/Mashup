# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
	
  before_filter :check_format, :set_format_mobi, :set_locale, :redirect_plug4life_to_mashup, :set_tag!

	private
	
		def set_tag!
			unless params.include? "tag"
				@tag = ""
			else
				@tag = params[:tag]
			end			
		end

		def check_format
	    if params.has_key? "format"
				redirect_to "http://mashup.#{self.request.domain}#{self.request.path}.#{params[:format]}"	unless self.request.path.match(/\.([a-z]{3,5})/)				
	    end
	  end

		def set_locale
      session[:locale] = nil
	    if params.has_key? "locale"
				redirect_to "http://mashup.#{self.request.domain}/#{params[:locale]}#{self.request.path}"	unless self.request.path.match(/\/(en|es)/) unless params[:locale] == I18n.default_locale				
	      I18n.locale = params[:locale]
	    end
	  end

		def set_format_mobi	
			params[:format] = "xhtml" if self.request.domain == 'cancaonova.mobi'
		end
	  
	  def redirect_plug4life_to_mashup
	    if self.request.domain == 'plug4life.com' 
	      redirect_to 'http://mashup.cancaonova.com/', :status=>:moved_permanently
	    end
	  end

end
