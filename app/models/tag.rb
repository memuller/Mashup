class Tag
	@url_feed = Hash.new
	@url_feed[:blog] = "http://blogsearch.google.com/blogsearch_feeds?scoring=d&num=10&start=1&q=##"

	@url_feed[:news] = "http://news.google.com.br/news?cf=all&output=rss&q=##"

	@url_feed[:bookmark] = "http://feeds.delicious.com/v2/xml/recent/?count=10&page=1&tag=##"

	@url_feed[:video] = "http://gdata.youtube.com/feeds/api/videos/?orderby=published&start-index=1&max-results=10&search=tag&category=##"
	@url_feed[:video_query] = "http://gdata.youtube.com/feeds/api/videos/?orderby=published&start-index=1&max-results=10&q=##"
		# feed://www.webtvcn.com/feed
		# feed://www.dailymotion.com/rss/search/%22canção+nova%22
		# http://br.video.yahoo.com/rss/video/search?p=cancaonova
		# http://pipes.yahoo.com/pipes/pipe.run?_id=sA_Kq5ku3RGWYeJBl7okhQ&_render=rss&tag=cancaonova
	@url_feed[:photo] = "http://www.flickr.com/services/feeds/photos_public.gne?format=rss_200&tags=[##]"

	@url_feed[:microblog] = "http://search.twitter.com/search.atom?rpp=10&page=1&q=##"
#	@url_feed[:microblog_query] = "http://search.twitter.com/search.atom?rpp=10&page=1&q=##"
#http://search.twitter.com/search.atom?q=&ands=&phrase=&ors=cancaonova+cançãonova&nots=&tag=&lang=all&from=&to=&ref=&near=&within=15&units=mi&since=&until=&rpp=10
	
	def self.all_rss tag
			fetch_and_parse_feed( @url_feed, tag )[0...20]	
	end
	
	def self.all_mrss tag
				midias = {:video => @url_feed[:video],:video_query => @url_feed[:video_query], :photo => @url_feed[:photo]}
				fetch_and_parse_feed( midias, tag )[0...20]	
	end
			
	def self.all tag
		{
			:blogs => blog( tag)[0...5]	, 
			:news => news( tag)[0...5]	, 
			:bookmarks => bookmark( tag)[0...5]	,
			:videos => video( tag)[0...10],
			:microblogs => microblog( tag)[0...10],
			:photos => photo( tag)[0...10]	
		}
	end

	def self.blog tag
		fetch_and_parse_feed( @url_feed[:blog], tag )[0...10]	
	end
	
	def self.news tag
		fetch_and_parse_feed( @url_feed[:news], tag )[0...10]		
	end
	
	def self.bookmark tag
		returno = fetch_and_parse_feed( @url_feed[:bookmark], tag )[0...10]		
	end
	
	def self.photo tag
		fetch_and_parse_feed( @url_feed[:photo], tag )[0...10]		
	end

	def self.video tag
		fetch_and_parse_feed( {
											:video => @url_feed[:video], 
											:video_query => @url_feed[:video_query]
											}	, tag )[0...10]		

	end

	def self.microblog tag
		fetch_and_parse_feed( {
										:microblog => @url_feed[:microblog]
										}, tag )[0...10]		

	end

	def self.get_feed type, tag
		fetch_and_parse_feed( {
										type => @url_feed[type], 
										"#{type}_query" => @url_feed["#{type}_query"]
										}, tag )[0...10]		
	end

	#TODO refactoring method, too long
	# => alterar para a mediana, segundo quartil, e terceiro quartil
	#
	def self.timeline tag
		feed = fetch_and_parse_feed( @url_feed, tag )[0...20]			
		return {} if feed.empty?
		
		half_hour, hour, two_hour,four_hour, eight_hour = [], [], [], [], []

		interval_initial = feed.first[4].to_i
		interval_final = feed.last[4].to_i
		interval_2 = (interval_initial + interval_final) /2
		interval_1 = (interval_initial + interval_2) /2
		interval_3 = (interval_2 + interval_final) /2

		feed.each do |sort|	
			if sort[4] > Time.at(interval_1)
				half_hour << sort
			elsif sort[4] > Time.at(interval_2) 
				hour << sort
			elsif sort[4] > Time.at(interval_3)
				two_hour << sort
			else 
				four_hour << sort
			end
		end
		
		{
			Time.at(interval_1) => half_hour, 
			Time.at(interval_2) => hour, 
			Time.at(interval_3) => two_hour, 
			Time.at(interval_final) => four_hour
		}
	end


	private 

		#TODO refactoring method, too long
		def self.fetch_and_parse_feed feed_url, tag			 
			feed_urls = []
			if feed_url.is_a? Hash
				feed_url.each do |url|
					quotes = url[0].to_s == "video"
					@is_photo = url[0].to_s.include? "photo"
					if @is_photo or  url[0].to_s.include? "bookmark"
						feed_urls << set_feed( url[1], default_tag( tag ) )	<< set_feed( url[1], tilde_tag( tag ) ) <<	set_feed( url[1], space_tilde_tag( tag , quotes) ) <<	set_feed( url[1], space_tag( tag , quotes) )						
					elsif url[0].to_s.include? "microblog"
						feed_urls << set_feed( url[1], or_microblog( tag ) )
					elsif
						feed_urls << set_feed( url[1], add_cn_tags( tag , quotes) )								
					end
				end
			else
				quotes = feed_url.include?( @url_feed[:video] )	
				@is_photo = feed_url.include? "flickr.com"
				if @is_photo or  feed_url.to_s.include? "delicious.com"
					feed_urls = [
									set_feed( feed_url, default_tag( tag ) ),			
									set_feed( feed_url, tilde_tag( tag ) )	,		
									set_feed( feed_url, space_tilde_tag( tag, quotes) ),
									set_feed( feed_url, space_tag( tag , quotes ) )						
								]	
				elsif feed_url.to_s.include? "twitter.com"
					feed_urls = set_feed( feed_url, or_microblog( tag ) )
				else
					feed_urls = set_feed( feed_url, add_cn_tags( tag , quotes) )								
				end
			end
						
			@to_merge = []

			Feedzirra::Feed.add_common_feed_entry_element("media:thumbnail", 
			:value => :url, :as => :thumbnail)		
			
			Feedzirra::Feed.fetch_and_parse(
				feed_urls,		
				:on_success => lambda {|feedurl, feeditem|
					feeditem.entries.each do |entry|
						check_duplicate = 0
						check_duplicate = @to_merge.find_all{ |i| i[0] == entry.id }.size if @to_merge.size > 0 				
						if check_duplicate == 0 
									type = media_type(feedurl)
									entry.thumbnail = entry.links[1] if type == "microblog"	
									entry.url = remove_redirect_url( entry.url) if type == "news" or type == "blog"
									
									@to_merge.push(
											[entry.id,
											entry.author,
											entry.title,
											(entry.content.nil?) ? entry.summary : entry.content,
											entry.published,
											entry.url,
											entry.thumbnail,
											type ]
										)
						end
					end	
				
				},	
				:on_failure => lambda {|url, response_code, response_header, response_body|
					RAILS_DEFAULT_LOGGER.error { "Url feed	= #{url} | code = #{response_code} | header = #{response_header}" }
				}
			)
			@to_merge.uniq!
			@to_merge.sort{ |row1,row2| row1[4] <=> row2[4]}.reverse			
		end

		def self.set_feed feed, tag
			feed.gsub( %r{##}, tag ) unless feed.nil?
		end

		def self.remove_redirect_url url		
				url = CGI::unescape(url).gsub("http://news.google.com/news/url?fd=R&sa=T&url=","").gsub(/http:\/\/www.cancaonova.com\/rd\/rd_dt.php\?id=[0-9]*\&url=/,"").gsub(/http:\/\/www.cancaonova.com\/rd\/rd_pr.php\?id=[0-9]*\&url=/,"")	
				url = CGI::unescape(url)
		end
		
		def self.media_type url
			case url.match(/([a-z]*\.[a-z]*).com/)[1]
				when "search.twitter" then "microblog"
				when "news.google" then "news"
				when "blogsearch.google" then "blog"
				when "www.flickr" then "photo"
				when "gdata.youtube" then "video"
				when "feeds.delicious" then "bookmark"
			end
		end
		
		def self.merge_feed feed_list, feed_hash
			return_feed = []
			feed_list.each do |feed|
				return_feed = return_feed | feed_list[feed.first].entries	
			end
		end
		
		def self.or_microblog tag
	    result = remove_tag_default tag
			quote = false			
			tag + "&ors=cancaonova+#{CGI::escape("cançãonova")}+#{quote_tags("cancao%20nova",quote)}+#{quote_tags(CGI::escape("canção%20nova"), quote)}"	
		end
			
	  def self.add_cn_tags(tags, quote)
	    result = remove_tag_default tags
			result + "+cancaonova" #"+(cancaonova|#{CGI::escape("cançãonova")}|#{quote_tags("cancao%20nova",quote)}|#{quote_tags(CGI::escape("canção%20nova"), quote)})"
	  end

	  def self.default_tag(tags)
	    change_tag_default(tags, "cancaonova")
	  end

	  def self.space_tag(tags, quote = false)
	    change_tag_default(tags, quote_tags("cancao%20nova",quote))
	  end

	  def self.tilde_tag(tags)
	    change_tag_default(tags, CGI::escape("cançãonova"))
	  end

	  def self.space_tilde_tag(tags, quote = false)
	    change_tag_default(tags, quote_tags(CGI::escape("canção%20nova"), quote))
	  end

	  def self.change_tag_default(tags, new_tag)
	    result = remove_tag_default tags
	    separator = @is_photo ? "," : "+"
			result + separator + new_tag
	  end

	  def self.remove_tag_default(tags=nil)
			unless tags.nil?
				tags.gsub(/\s+/,'+')
				%w(+cancaonova.com cancaonova.com+ cancaonova.com +cancaonova cancaonova+ cancaonova can%C3%A7%C3%A3o%20nova cancao_nova / %2F).each do |var|
				  tags.to_s.gsub!("#{var}", nil.to_s)
				end			
			end
			tags.to_s
	  end

		def self.remove_slash(tags=nil)
			tags.gsub('/','').gsub('%2F','')
		end

		def self.quote_tags tags, quote = false
				tags = "%22#{tags}%22" unless quote
				tags
		end

end