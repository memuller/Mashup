class Mashup

	@feed_urls = ["http://blogsearch.google.com/blogsearch_feeds?scoring=d&num=10&start=1&q=cancaonova",
								"http://blogsearch.google.com/blogsearch_feeds?scoring=d&num=10&start=1&q=cançãonova",			
	 						 "http://feeds.delicious.com/v2/xml/recent/?count=10&page=1&tag=cancaonova",
							"http://gdata.youtube.com/feeds/api/videos/?orderby=published&start-index=1&max-results=10&search=tag&category=cancaonova",	
							"http://www.flickr.com/services/feeds/photos_public.gne?format=rss_200&tags=[cancaonova]"	,
							"http://search.twitter.com//search.atom?rpp=10&page=1&tag=cancaonova"
							]
	@feed_urls_TEMP = ["http://blogsearch.google.com/blogsearch_feeds?scoring=d&num=10&start=1&q=cancaonova",
									"http://blogsearch.google.com/blogsearch_feeds?scoring=d&num=10&start=1&q=cançãonova",			
		 						 "http://feeds.delicious.com/v2/xml/recent/?count=10&page=1&tag=cancaonova",
								"http://gdata.youtube.com/feeds/api/videos/?orderby=published&start-index=1&max-results=10&search=tag&category=cancaonova",	
								"http://www.flickr.com/services/feeds/photos_public.gne?format=rss_200&tags=[cancaonova]"	,
								"http://search.twitter.com//search.atom?rpp=10&page=1&tag=cancaonova"
								]

	def self.all
		
		feeds = fetch_and_parse_feed(@feed_urls)				

		{ 
			:blogs => feeds[@feed_urls_TEMP[0]].entries, 
			:bookmarks => feeds[@feed_urls_TEMP[1]].entries,
			:videos => feeds[@feed_urls_TEMP[2]].entries,
			:photos => feeds[@feed_urls_TEMP[3]].entries,
			:microtexts => feeds[@feed_urls_TEMP[4]].entries
		}
	end

	def self.blog
		feed = fetch_and_parse_feed([@feed_urls_TEMP[0],@feed_urls_TEMP[1]])	
		merge_feed(feed,[@feed_urls[0],@feed_urls[1]]	)		
	end

	def self.bookmark
		feed_urls = @feed_urls[2]	
		fetch_and_parse_feed(feed_urls).entries				
	end

	def self.video
		feed_urls = @feed_urls[3]	
		fetch_and_parse_feed(feed_urls).entries				
	end

	def self.photo
		feed_urls = @feed_urls[4]	
		fetch_and_parse_feed(feed_urls).entries				
	end

	def self.microtext
		feed_urls = @feed_urls[5]	
		fetch_and_parse_feed(feed_urls).entries				
	end

	def self.timeline
		feed_urls = @feed_urls[5]	
		feed = fetch_and_parse_feed(feed_urls).entries

		half_hour, hour, two_hour,four_hour, eight_hour = [], [], [], [], []

		feed.each do |sort|
			if sort.published > 30.minutes.ago
RAILS_DEFAULT_LOGGER.debug "30 minutes ago #{sort.published} < #{30.minutes.ago}"				 
				half_hour << sort
			elsif sort.published > 1.hour.ago 
				hour << sort
			elsif sort.published > 2.hour.ago 
				two_hour << sort
			elsif sort.published > 4.hour.ago 
				four_hour << sort
			else 
				eight_hour << sort
			end
		end
		{ :half_hour=> half_hour, :hour => hour, :two_hour => two_hour, :four_hour => four_hour, :eight_hour => eight_hour}
	end



	private 

		def self.fetch_and_parse_feed feed_urls		
			feed = Feedzirra::Feed.fetch_and_parse(feed_urls)		
			
#			:on_success => lambda {|feed| puts feed.title },
#			:on_failure => lambda {|url, response_code, response_header, response_body| puts response_body })

		end

		def self.merge_feed feed_list, feed_hash
			return_feed = []
			feed_list.each do |feed|
				return_feed = return_feed | feed_list[feed.first].entries	
			end
			
		end

		def set_tag
			params[:tag] = "cancaonova" if params[:tag].nil?
		end

		def to_param
			params[:page] = "1" if params[:page].nil?
		end


end