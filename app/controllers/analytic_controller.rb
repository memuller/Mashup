class AnalyticController < ApplicationController
  def index
		gs = Gattica.new({:email => 'marco.moura@gmail.com', :password => 'casado', :profile_id => 6535463})
		results = gs.get({ :start_date => '2008-01-01', :end_date => '2009-02-01', :dimensions => 'browser', :metrics => 'pageviews'})
  end

end
