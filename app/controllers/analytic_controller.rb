class AnalyticController < ApplicationController
  def index
			@data = Analytic.index
  end

end

