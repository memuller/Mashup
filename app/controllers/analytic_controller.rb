class AnalyticController < ApplicationController
	
	caches_page :index
	
  def index
			@tag = "cancaonova"
			@data = Analytic.index
  end

end

