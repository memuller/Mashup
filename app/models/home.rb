class Home
	
	def self.all
		initialize
		{
			:all_time => all_time,
			:last_7_days => last_7_days,
			:last_day => last_day
		}
	end

	protected
	
		def self.initialize
			@ga = Gattica.new({:email => 'multimedia@cancaonova.com', :password => 'si3ooBu#', :profile_id => 13213266})
		end

		def self.all_time
			fetch_analytic( DateTime.now - 1.year)
		end

		def self.last_7_days
			fetch_analytic( DateTime.now - 1.week)
		end

		def self.last_day
			fetch_analytic( DateTime.now - 1.day)
		end
		
		private
		
			def self.fetch_analytic start_date
				@ga.get(
								{ 
									:start_date => start_date.strftime("%Y-%m-%d"), 
		              :end_date => DateTime.now.strftime("%Y-%m-%d"),
		              :dimensions => ['pageTitle'],
		              :metrics => ['pageviews'],
		              :sort => ['-pageviews'] 
								}
							 )
				
			end
end