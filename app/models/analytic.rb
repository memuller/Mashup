class Analytic
	
	def self.index
		initialize
		{:all_time => all_time,
		:last_7_days => last_7_days}
	end

	protected
	
		def self.initialize
			@ga = Gattica.new({:email => 'multimedia@cancaonova.com', :password => 'si3ooBu#', :profile_id => 13213266})
		end

		def self.all_time
			@ga.get({ :start_date => '2008-10-01', 
	              :end_date => DateTime.now.strftime("%Y-%m-%d"),
	              :dimensions => ['pageTitle'],
	              :metrics => ['pageviews'],
	              :sort => ['-pageviews'] })
		end

		def self.last_7_days
			@ga.get({ :start_date => (DateTime.now - 1.week).strftime("%Y-%m-%d"), 
	              :end_date => (DateTime.now).strftime("%Y-%m-%d"),
	              :dimensions => ['pageTitle'],
	              :metrics => ['pageviews'],
	              :sort => ['-pageviews'] })
		end


end