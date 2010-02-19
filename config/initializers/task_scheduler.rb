require 'rake'
require 'rufus/scheduler'
load File.join( RAILS_ROOT, 'Rakefile')

scheduler = Rufus::Scheduler.start_new

scheduler.every '1m', :timeout => '5m'  do
	Dir[File.join("#{RAILS_ROOT}/public/**","*.{html,atom,mrss,xhtmlmp}")].each do |entry|
		if Time.now > File::mtime(entry) + 180 
			File.delete(entry) if File::exists?(entry)
		end
	end
end