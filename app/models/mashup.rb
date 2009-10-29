class Mashup
	
	def self.all
		feed_urls = ["http://blogsearch.google.com/blogsearch_feeds?scoring=d&num=10&start=1&q=cancaonova",
			"http://feeds.delicious.com/v2/xml/recent/?count=10&page=1&tag=cancaonova"
								]	
debugger								
		fetch_and_parse_feed(feed_urls)				
	end

	def self.blog
		feed_urls = "http://blogsearch.google.com/blogsearch_feeds?scoring=d&num=10&start=1&q=cancaonova"	
								#,"http://blogsearch.google.com/blogsearch_feeds?scoring=d&num=10&start=#{:page}&q=cançãonova+"+:tag
								#]	
		fetch_and_parse_feed(feed_urls)				
	end

	def self.bookmark
		feed_urls = "http://feeds.delicious.com/v2/xml/recent/?count=10&page=1&tag=cancaonova"	
								#,"http://blogsearch.google.com/blogsearch_feeds?scoring=d&num=10&start=#{:page}&q=cançãonova+"+:tag
								#]	
		fetch_and_parse_feed(feed_urls)				
	end

	def self.video
		page = 1
		feed_urls = "http://gdata.youtube.com/feeds/api/videos/?orderby=published&start-index=#{page}&max-results=10&search=tag&category=cancaonova"	
								#,"http://blogsearch.google.com/blogsearch_feeds?scoring=d&num=10&start=#{:page}&q=cançãonova+"+:tag
								#]	
		fetch_and_parse_feed(feed_urls)				
	end

	def self.photo
		feed_urls = "http://www.flickr.com/services/feeds/photos_public.gne?format=rss_200&tags=[cancaonova]"	
								#,"http://blogsearch.google.com/blogsearch_feeds?scoring=d&num=10&start=#{:page}&q=cançãonova+"+:tag
								#]	
		fetch_and_parse_feed(feed_urls)				
	end

	def self.microtext
		page = 1
		feed_urls = "http://search.twitter.com//search.atom?rpp=10&page=#{page}&tag=cancaonova"	
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
			feed = Feedzirra::Feed.fetch_and_parse(feed_urls)		
			
#			:on_success => lambda {|feed| puts feed.title },
#			:on_failure => lambda {|url, response_code, response_header, response_body| puts response_body })

		end

end