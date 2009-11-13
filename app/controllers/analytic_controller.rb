class AnalyticController < ApplicationController
  def index


		ga = Gattica.new({:email => 'marcomoura@gmail.com', :password => 'casado', :profile_id => 13213266})

		# or, initialize via a pre-existing token. This initialization does not authenticate immediately, 
		# but will throw an error on subsequent calls (like ga.accounts) if the token is invalid
		# ga = Gattica.new({:token => 'DQAAAJYAAACN-JMelka5I0Fs-T6lF53eUSfUooeHgcKc1iEdc0wkDS3w8GaXY7LjuUB_4vmzDB94HpScrULiweW_xQsU8yyUgdInDIX7ZnHm8_o0knf6FWSR90IoAZGsphpqteOjZ3O0NlNt603GgG7ylvGWRSeHl1ybD38nysMsKJR-dj0LYgIyPMvtgXLrqr_20oTTEExYbrDSg5_q84PkoLHUcODZ' })

		# get the list of accounts you have access to with that username and password
#accounts = ga.accounts

		# for this example we just use the first account's profile_id, but you'll probably want to look
		# at this list and choose the profile_id of the account you want (the web_property_id is the
		# property you're most used to seeing in GA, looks like UA123456-1)
#ga.profile_id = accounts.first.profile_id
#debugger
		# If you're using Gattica with a web app you'll want to save the authorization token
		# and use that on subsequent requests (Google recommends not re-authenticating each time)
		# ga.token

		# now get the number of page views by browser for Janurary 2009
		@data = ga.get({ :start_date => '2008-10-01', 
		                :end_date => '2009-11-12',
		                :dimensions => ['pageTitle'],
		                :metrics => ['pageviews'],
		                :sort => ['-pageviews'] })


  end

end

