require 'rake'
require 'rufus/scheduler'
load File.join( RAILS_ROOT, 'Rakefile')

scheduler = Rufus::Scheduler.start_new  

scheduler.every '5m' do
	puts 'check blood pressure'
end