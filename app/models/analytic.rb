class Analytic
	
	def after_initialize
debugger
		@ga = Gattica.new({:email => 'multimedia@cancaonova.com', :password => 'si3ooBu#', :profile_id => 13213266})
	end
	
	def self.all
			@ga.get({ :start_date => '2008-10-01', 
			                :end_date => DateTime.now.strftime("%Y-%m-%d"),
			                :dimensions => ['pageTitle'],
			                :metrics => ['pageviews'],
			                :sort => ['-pageviews'] })

	end

	def last_week
		@ga.get({ :start_date => (DateTime.now - 1.year - 1.week).strftime("%Y-%m-%d"), 
			                :end_date => (DateTime.now - 1.year).strftime("%Y-%m-%d"),
			                :dimensions => ['pageTitle'],
			                :metrics => ['pageviews'],
			                :sort => ['-pageviews'] })
	end

end