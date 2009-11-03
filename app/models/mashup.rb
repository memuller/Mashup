class Mashup

	@feed_urls = ["http://blogsearch.google.com/blogsearch_feeds?scoring=d&num=10&start=1&q=cancaonova",
								"http://blogsearch.google.com/blogsearch_feeds?scoring=d&num=10&start=1&q=cançãonova",			
	 						 "http://feeds.delicious.com/v2/xml/recent/?count=10&page=1&tag=cancaonova",
							"http://gdata.youtube.com/feeds/api/videos/?orderby=published&start-index=1&max-results=10&search=tag&category=cancaonova",	
							"http://www.flickr.com/services/feeds/photos_public.gne?format=rss_200&tags=[cancaonova]"	,
							"http://search.twitter.com//search.atom?rpp=10&page=1&tag=cancaonova"
							]
	@feed_urls_TEMP = ["http://blogsearch.google.com/blogsearch_feeds?scoring=d&num=10&start=1&q=cancaonova",	
	 						 "http://feeds.delicious.com/v2/xml/recent/?count=10&page=1&tag=cancaonova",
							"http://gdata.youtube.com/feeds/api/videos/?orderby=published&start-index=1&max-results=10&search=tag&category=cancaonova",	
							"http://www.flickr.com/services/feeds/photos_public.gne?format=rss_200&tags=[cancaonova]"	,
							"http://search.twitter.com//search.atom?rpp=10&page=1&tag=cancaonova"
							]

	def self.all
		
		feeds = fetch_and_parse_feed(@feed_urls)				

		{ 
			:blogs => feeds[@feed_urls_TEMP[0]], 
			:bookmarks => feeds[@feed_urls_TEMP[1]],
			:videos => feeds[@feed_urls_TEMP[2]],
			:photos => feeds[@feed_urls_TEMP[3]],
			:microtexts => feeds[@feed_urls_TEMP[4]]
		}
	end

	def self.blog
		feed_urls = [@feed_urls[0],@feed_urls[1]]	
		feed = fetch_and_parse_feed(feed_urls)	
		merge_feed(feed)		
	end

	def self.bookmark
		feed_urls = @feed_urls[1]	
		fetch_and_parse_feed(feed_urls)				
	end

	def self.video
		page = 1
		feed_urls = @feed_urls[2]	
		fetch_and_parse_feed(feed_urls)				
	end

	def self.photo
		feed_urls = @feed_urls[3]	
		fetch_and_parse_feed(feed_urls)				
	end

	def self.microtext
		page = 1
		feed_urls = @feed_urls[4]	
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
			feed = Feedzirra::Feed.fetch_and_parse(feed_urls)		
			
#			:on_success => lambda {|feed| puts feed.title },
#			:on_failure => lambda {|url, response_code, response_header, response_body| puts response_body })

		end

		def self.merge_feed feed_list
			return_feed = []
debugger
			feed_list.each do |feed|
				return_feed = return_feed | feed.entries			
			end
			
		end
end