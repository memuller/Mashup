# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
	
  before_filter :set_format_mobi, :set_locale, :redirect_plug4life_to_mashup

	def set_locale

    if params[:locale]
      I18n.locale = params[:locale]
		else
      I18n.locale = 'pt-BR' and params[:locale] = 'pt-BR'
    end

  rescue Exception => err
    logger.error err
    flash.now[:notice] = "#O idioma “{I18n.locale}” não está disponível"

    I18n.load_path -= [locale_path]
    I18n.locale = I18n.default_locale
  end

	def set_format_mobi
		request.format = :xhtml if self.request.domain == 'cancaonova.mobi'
	end
	  
  def redirect_plug4life_to_mashup
    if self.request.domain == 'plug4life.com' 
      redirect_to 'http://mashup.cancaonova.com/', :status=>:moved_permanently
    end
  end

end
