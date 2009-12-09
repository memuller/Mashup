class Tag

	@blog_feed = "http://blogsearch.google.com/blogsearch_feeds?scoring=d&num=10&start=1&q=##"

	def self.initialize tag = nil
RAILS_DEFAULT_LOGGER.debug "message tag = "+tag
		@tag = tag
		@feed_urls = ["http://blogsearch.google.com/blogsearch_feeds?scoring=d&num=10&start=1&q=cancaonova,"+@tag,
									"http://blogsearch.google.com/blogsearch_feeds?scoring=d&num=10&start=1&q=cançãonova+"+@tag,			
		 						 "http://feeds.delicious.com/v2/xml/recent/?count=10&page=1&tag=cancaonova,"+@tag,
								"http://gdata.youtube.com/feeds/api/videos/?orderby=published&start-index=1&max-results=10&search=tag&category=cancaonova+"+@tag,	
								"http://www.flickr.com/services/feeds/photos_public.gne?format=rss_200&tags=[cancaonova,"+@tag+"]"	,
								"http://search.twitter.com/search.atom?rpp=10&page=1&tag=cancaonova+"+@tag
								]
		@feed_urls_TEMP = ["http://blogsearch.google.com/blogsearch_feeds?scoring=d&num=10&start=1&q=cancaonova,"+@tag,
										"http://blogsearch.google.com/blogsearch_feeds?scoring=d&num=10&start=1&q=cançãonova,"+@tag,			
			 						 "http://feeds.delicious.com/v2/xml/recent/?count=10&page=1&tag=cancaonova,"+@tag,
									"http://gdata.youtube.com/feeds/api/videos/?orderby=published&start-index=1&max-results=10&search=tag&category=cancaonova+"+@tag,	
									"http://www.flickr.com/services/feeds/photos_public.gne?format=rss_200&tags=[cancaonova,"+@tag+"]"	,
									"http://search.twitter.com/search.atom?rpp=10&page=1&tag=cancaonova+"+@tag
									]
	end
		
	def self.all tag
		initialize tag
		feeds = fetch_and_parse_feed( @feed_urls)				

		{ :blogs => feeds[@feed_urls_TEMP[0]].entries, 
			:bookmarks => feeds[@feed_urls_TEMP[1]].entries,
			:videos => feeds[@feed_urls_TEMP[2]].entries,
			:photos => feeds[@feed_urls_TEMP[3]].entries,
			:microtexts => feeds[@feed_urls_TEMP[4]].entries
		}
	end

	def self.blog tag
		url = set_feed( @blog_feed, tag )			

#		url = []
#			url << set_feed( @blog_feed, default_tag( tag ) )			
#			url << set_feed( @blog_feed, tilde_tag( tag ) )			
#			url << set_feed( @blog_feed, space_tag( tag ) )			
#			url << set_feed( @blog_feed, space_tilde_tag( tag ) )			


		fetch_and_parse_feed( url ).entries	
	end
	
	def self.bookmark
		url = set_feed( @blog_feed, tag )
		fetch_and_parse_feed( url ).entries	

		feed_urls = @feed_urls[2]	
		fetch_and_parse_feed(feed_urls).entries				
	end

	def self.video
		feed_urls = @feed_urls[3]	
		fetch_and_parse_feed(feed_urls).entries				
	end

	def self.photo
		feed_urls = @feed_urls[4]	
		fetch_and_parse_feed( feed_urls).entries				
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

		def self.set_feed feed, tag
			feed.gsub( %r{##}, tag )
		end

		def self.fetch_and_parse_feed feed_urls		
			Feedzirra::Feed.fetch_and_parse(
				feed_urls,		
				:on_success => lambda {|url, feed| 
					
RAILS_DEFAULT_LOGGER.debug feed.size					
					
					if feed.url.include? "search.twitter.com"
						feed.entries.each do |entry|
							RAILS_DEFAULT_LOGGER.debug  entry.title
						end
					end
				},	
				:on_failure => lambda {|url, response_code, response_header, response_body|
#					puts response_body + 
					puts "ERROR RETORNO	"
					[:entries]
				}
			)
		end

		def self.merge_feed feed_list, feed_hash
			return_feed = []
			feed_list.each do |feed|
				return_feed = return_feed | feed_list[feed.first].entries	
			end
			
		end

		def to_param
			params[:page] = "1" if params[:page].nil?
		end




	  def default_tag(tags=nil)
	    change_tag_default(tags, "cancaonova")
	  end

	  def tilde_tag(tags=nil)
	    change_tag_default(tags, "cançãonova")
	  end

	  def space_tag(tags=nil)
	    change_tag_default(tags, "cancao%20nova")
	  end

	  def space_tilde_tag(tags=nil)
	    change_tag_default(tags, "canção%20nova")
	  end

	  def comma_tag(tags=nil)
	    change_tag_default(tags, "cancao,nova")
	  end

	  def comma_tilde_tag(tags=nil)
	    change_tag_default(tags, "canção,nova")
	  end

	  def change_tag_default(tags, new_tag)
	    result = remove_tag_default tags
	    result == nil ? quote_tags(new_tag) : result + quote_tags(new_tag)
	  end

	  def remove_tag_default(tags=nil)
			unless tags.nil?
				tags.gsub(/\s+/,'+')

				%w(+cancaonova.com cancaonova.com+ cancaonova.com +cancaonova cancaonova+ cancaonova can%C3%A7%C3%A3o%20nova cancao_nova / %2F).each do |var|
				  tags.to_s.gsub!("[#{var}]", '')
				end			

				%w(++ %20).each do |var|
					tags.to_s.gsub!("[#{var}]", '+')
				end
				tags.gsub!(%r{&} , "+")
				tags.gsub(/([^ a-zA-Z0-9_.-\\+]+)/n,"")
			end

			tags.to_s
	  end

		def remove_slash(tags=nil)
			tags.gsub('/','').gsub('%2F','')
		end

		def quote_tags tags
				"%22#{tags}%22"
		end

end