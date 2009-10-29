atom_feed do |feed|
	feed.title "blogs list" 
	feed.updated @blogs.entries.first.published 

	@blogs.entries.each do |blog|

		feed.entry blog do |entry| 
			entry.title blog.title 
			entry.content blog.description, :type => 'html' 
		end

	end

end