class Tag
	@url_feed = Hash.new
	@url_feed[:blog] = "http://blogsearch.google.com/blogsearch_feeds?scoring=d&num=10&start=1&q=##"

	@url_feed[:bookmark] = "http://feeds.delicious.com/v2/xml/recent/?count=10&page=1&tag=##"

	@url_feed[:video_tag] = "http://gdata.youtube.com/feeds/api/videos/?orderby=published&start-index=1&max-results=10&search=tag&category=##"
	@url_feed[:video] = "http://gdata.youtube.com/feeds/api/videos/?orderby=published&start-index=1&max-results=10&q=##"

	@url_feed[:photo] = "http://www.flickr.com/services/feeds/photos_public.gne?format=rss_200&tags=[##]"

	@url_feed[:microtext] = "http://search.twitter.com/search.atom?rpp=10&page=1&tag=##"

		
	def self.all tag, atom = nil

		unless atom.nil?
			fetch_and_parse_feed( @url_feed, tag )[0...20]	
		else
			{
				:blogs => blog( tag), 
				:bookmarks => bookmark( tag),
				:videos => video( tag),
				:microtexts => microtext( tag),
				:photos => photo( tag)
			}
		end
	end

	def self.blog tag
		fetch_and_parse_feed( @url_feed[:blog], tag )	
	end
	
	def self.bookmark tag
		fetch_and_parse_feed( @url_feed[:bookmark], tag )	
	end
	
		def self.video tag
			fetch_and_parse_feed( @url_feed[:video], tag )	
		end

		def self.photo tag
			@is_photo = true
			fetch_and_parse_feed( @url_feed[:photo], tag )	
		end

		def self.microtext tag
			fetch_and_parse_feed( @url_feed[:microtext], tag )	
		end



	def self.timeline tag
		feed = fetch_and_parse_feed( @url_feed, tag )[0...20]			
		
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

		def self.set_feed feed, tag
			feed.gsub( %r{##}, tag )
		end

		def self.fetch_and_parse_feed feed_url, tag			 
			feed_urls = []
			if feed_url.class == Hash
				feed_url.each do |url|
					feed_urls << set_feed( url[1], default_tag( tag ) )	<< set_feed( url[1], tilde_tag( tag ) ) <<	set_feed( url[1], space_tilde_tag( tag ) ) <<	set_feed( url[1], space_tag( tag ) )						
				end
			else
				feed_urls = [
								set_feed( feed_url, default_tag( tag ) ),			
								set_feed( feed_url, tilde_tag( tag ) ),			
								set_feed( feed_url, space_tilde_tag( tag ) ),
								set_feed( feed_url, space_tag( tag ) )						
							]	
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
								@to_merge.push(
										[entry.id,
										entry.author,
										entry.title,
										(entry.content.nil?) ? entry.summary : entry.content,
										entry.published,
										entry.url,
										entry.thumbnail]
									)
						end
					end	
				
				},	
				:on_failure => lambda {|url, response_code, response_header, response_body|
#					puts response_body + 
					puts "ERROR RETORNO	= #{url}"
				}
			)
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