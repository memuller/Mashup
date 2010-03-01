xml.instruct!

# RSS2 rxml template based on: http://snippets.dzone.com/posts/show/558
xml.rss "version" => "2.0",
				"xmlns:atom" => "http://www.w3.org/2005/Atom",
        "xmlns:media" => "http://search.yahoo.com/mrss/" do

    xml.channel do

        xml.title       "MRSS Mashup Cancanova"
 	      xml.link        url_for(:format => "mrss", :only_path => false) 
				xml.atom :link, :href => url_for(:format => "mrss", :only_path => false), :rel=> "self" 
 				updated = 			@entries.any? ? Time.now : @entries[0][4] 
        xml.pubDate     CGI.rfc1123_date(updated)
        xml.description "MRSS Mashup Cancanova"
				xml.icon				"/favicon.ico"

		   #<atom:link rel="previous" href="http://mysite.com/feed1.rss" />
		   #<atom:link rel="next" href="http://mysite.com/feed2.rss" />

        @entries.each do |post|
            xml.item do

                xml.title       post[2]
                xml.link        post[5]
                xml.description post[3]
                xml.pubDate     CGI.rfc1123_date post[4]
                xml.guid        post[5]

                xml.media :group do
                    xml.media :title, post[2]
										
										if post[5].include? "youtube.com"
	                  	xml.media :content, :type => "application/x-shockwave-flash", :url => "#{url_player_video post[5]}"
	                  	xml.media :player, :url => "#{url_player_video post[5]}"
                    else
	                   	xml.media :content, :type => "image", :url => "#{medium_photo_url post[6]}"	
										end
										xml.media :description, "#{post[3]}", :type => 'html'
                    xml.media :thumbnail, :url => post[6]
                end
            end
        end

    end
end