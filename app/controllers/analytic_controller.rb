class AnalyticController < ApplicationController
	
	caches_page :index
	
  def index
			@data = Analytic.index
  end

end

