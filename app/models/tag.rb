class Tag
	@url_feed = Hash.new
	@url_feed[:blog] = "http://blogsearch.google.com/blogsearch_feeds?scoring=d&num=10&start=1&q=##"

	@url_feed[:bookmark] = "http://feeds.delicious.com/v2/xml/recent/?count=10&page=1&tag=##"

	@url_feed[:video_tag] = "http://gdata.youtube.com/feeds/api/videos/?orderby=published&start-index=1&max-results=10&search=tag&category=##"
	@url_feed[:video] = "http://gdata.youtube.com/feeds/api/videos/?orderby=published&start-index=1&max-results=10&q=##"

	@url_feed[:photo] = "http://www.flickr.com/services/feeds/photos_public.gne?format=rss_200&tags=[##]"

	@url_feed[:microtext] = "http://search.twitter.com/search.atom?rpp=10&page=1&tag=##"

	def self.initialize tag = nil
RAILS_DEFAULT_LOGGER.debug "message tag = "+tag
		@tag = tag
		@feed_urls = ["http://blogsearch.google.com/blogsearch_feeds?scoring=d&num=10&start=1&q=,"+@tag,
		 						 "http://feeds.delicious.com/v2/xml/recent/?count=10&page=1&tag=,"+@tag,
								"http://gdata.youtube.com/feeds/api/videos/?orderby=published&start-index=1&max-results=10&search=tag&category=cancaonova+"+@tag,	
								"http://www.flickr.com/services/feeds/photos_public.gne?format=rss_200&tags=[cancaonova,"+@tag+"]"	,
								"http://search.twitter.com/search.atom?rpp=10&page=1&tag=cancaonova+"+@tag
								]
		@feed_urls_TEMP = ["http://blogsearch.google.com/blogsearch_feeds?scoring=d&num=10&start=1&q=,"+@tag,
			 						 "http://feeds.delicious.com/v2/xml/recent/?count=10&page=1&tag=,"+@tag,
									"http://gdata.youtube.com/feeds/api/videos/?orderby=published&start-index=1&max-results=10&search=tag&category=cancaonova+"+@tag,	
									"http://www.flickr.com/services/feeds/photos_public.gne?format=rss_200&tags=[cancaonova,"+@tag+"]"	,
									"http://search.twitter.com/search.atom?rpp=10&page=1&tag=cancaonova+"+@tag
									]
	end
		
	def self.all tag
		{
			:blogs => blog( tag), 
			:bookmarks => bookmark( tag),
			:videos => video( tag),
			:photos => photo( tag),
			:microtexts => microtext( tag)
		}
	end

	def self.blog tag
		url = [
						set_feed( @url_feed[:blog], default_tag( tag ) ),			
						set_feed( @url_feed[:blog], tilde_tag( tag ) ),			
						set_feed( @url_feed[:blog], space_tilde_tag( tag ) ),
						set_feed( @url_feed[:blog], space_tag( tag ) )						
					]	

		fetch_and_parse_feed( url )	
	end
	
	def self.bookmark tag
		url = [
						set_feed( @url_feed[:bookmark], default_tag( tag ) ),			
						set_feed( @url_feed[:bookmark], tilde_tag( tag ) ),			
						set_feed( @url_feed[:bookmark], space_tilde_tag( tag ) ),
						set_feed( @url_feed[:bookmark], space_tag( tag ) )						
					]	

		fetch_and_parse_feed( url )	
	end
	
		def self.video tag
			url_video = [
							set_feed( @url_feed[:video], default_tag( tag ) ),			
							set_feed( @url_feed[:video], tilde_tag( tag ) ),			
							set_feed( @url_feed[:video], space_tilde_tag( tag ) ),
							set_feed( @url_feed[:video], space_tag( tag ) )						
						]	

	#		url_video =	set_feed( @bookmark_feed, default_tag( tag ) )
			fetch_and_parse_feed( url_video )	
		end

		def self.photo tag
			@is_photo = true
			feed_url = [
							set_feed( @url_feed[:photo], default_tag( tag ) ),			
							set_feed( @url_feed[:photo], tilde_tag( tag ) ),			
							set_feed( @url_feed[:photo], space_tilde_tag( tag ) ),
							set_feed( @url_feed[:photo], space_tag( tag ) )						
						]	
			@is_photo = nil
	#		url_video =	set_feed( @bookmark_feed, default_tag( tag ) )
			fetch_and_parse_feed( feed_url )	
		end

		def self.microtext tag
			feed_url = [
							set_feed( @url_feed[:microtext], default_tag( tag ) ),			
							set_feed( @url_feed[:microtext], tilde_tag( tag ) ),			
							set_feed( @url_feed[:microtext], space_tilde_tag( tag ) ),
							set_feed( @url_feed[:microtext], space_tag( tag ) )						
						]	
			fetch_and_parse_feed( feed_url )	
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

			@to_merge = []
			Feedzirra::Feed.fetch_and_parse(
				feed_urls,		
				:on_success => lambda {|feedurl, feeditem|
RAILS_DEFAULT_LOGGER.debug "#{feedurl}"
					feeditem.entries.each do |entry|
						check_duplicate = 0
						check_duplicate = @to_merge.find_all{ |i| i[0] == entry.id }.size if @to_merge.size > 0 
						
						if check_duplicate == 0 						
								@to_merge.push(
										[entry.id,
										entry.author,
										entry.title,
										entry.content,
										entry.published,
										entry.url,
										(entry.methods.include?( "links")) ? entry.links[1] : nil]
									)
						end
					end	
				
				},	
				:on_failure => lambda {|url, response_code, response_header, response_body|
#					puts response_body + 
					puts "ERROR RETORNO	= #{url}"
				}
			)
			
/#
.each do
	
	feed.entries.each do |entry|
			@to_hash.push(
				0	"iten_id" => entry.id,
				1	"author" => entry.author,
				2	"content" => entry.content,
				3	"published" =>entry.published,
				4	"url" => entry.url,
				5	"links" => (entry.methods.include?( "links")) ? entry.links[1] : nil
				)
	end
/				
			@to_merge.uniq!
			@to_merge.sort{ |row1,row2| row1[4] <=> row2[4]}.reverse
			
		end
		
		
		def self.merge_feed feed_list, feed_hash
			return_feed = []
			feed_list.each do |feed|
				return_feed = return_feed | feed_list[feed.first].entries	
			end
			
		end

		def self.to_param
			params[:page] = "1" if params[:page].nil?
		end




	  def self.default_tag(tags=nil)
	    change_tag_default(tags, "cancaonova")
	  end

	  def self.tilde_tag(tags=nil)
	    change_tag_default(tags, "cançãonova")
	  end

	  def self.space_tag(tags=nil)
	    change_tag_default(tags, quote_tags("cancao%20nova"))
	  end

	  def self.space_tilde_tag(tags=nil)
	    change_tag_default(tags, quote_tags("canção%20nova"))
	  end

	  def self.comma_tag(tags=nil)
	    change_tag_default(tags, quote_tags("cancao,nova"))
	  end

	  def self.comma_tilde_tag(tags=nil)
	    change_tag_default(tags, quote_tags("canção,nova"))
	  end

	  def self.change_tag_default(tags, new_tag)
	    result = remove_tag_default tags
#	    result == nil ? quote_tags(new_tag) : result + quote_tags(new_tag)
	    if @is_photo
				result+","+new_tag
			else
				result+"+"+new_tag
			end
	  end

	  def self.remove_tag_default(tags=nil)
			unless tags.nil?
				tags.gsub(/\s+/,'+')

				%w(+cancaonova.com cancaonova.com+ cancaonova.com +cancaonova cancaonova+ cancaonova can%C3%A7%C3%A3o%20nova cancao_nova / %2F).each do |var|
				  tags.to_s.gsub!("[#{var}]", nil.to_s)
				end			

				%w(++ %20).each do |var|
					tags.to_s.gsub!("[#{var}]", '+')
				end
				tags.gsub!(%r{&} , "+")
				tags.gsub!(/([^ a-zA-Z0-9_.-\\+]+)/n,nil.to_s)
			end

			tags.to_s
	  end

		def self.remove_slash(tags=nil)
			tags.gsub('/','').gsub('%2F','')
		end

		def self.quote_tags tags
				"%22#{tags}%22"
		end

end