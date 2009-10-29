class Blog
	
	def self.all( page)
		feed_urls = "http://blogsearch.google.com/blogsearch_feeds?scoring=d&num=10&start=#{page}&q=cancaonova"	
								#,"http://blogsearch.google.com/blogsearch_feeds?scoring=d&num=10&start=#{:page}&q=cançãonova+"+:tag
								#]	
		fetch_and_parse_feed(feed_urls)				
	end

	def self.find( tag, page)
		feed_urls = "http://blogsearch.google.com/blogsearch_feeds?scoring=d&num=10&start=&q=dunga"	
								#,"http://blogsearch.google.com/blogsearch_feeds?scoring=d&num=10&start=#{:page}&q=cançãonova+"+:tag
								#]	
		fetch_and_parse_feed(feed_urls)				
	end


	def set_tag
		params[:tag] = "cancaonova" if params[:tag].nil?
	end
	
	def to_param
		params[:page] = "1" if params[:page].nil?
	end

	private 
	def self.fetch_and_parse_feed feed_urls		
		Feedzirra::Feed.fetch_and_parse(feed_urls)				
	end
end