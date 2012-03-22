# -*- encoding : utf-8 -*-
module TagHelper
	
	def embed_video url_video
		url_video = url_video.to_s
		url_video = "http://www.youtube.com/watch?v="+params[:video] if self.request.query_parameters.has_key? "video" 
		"<object width='640' height='385' codebase='http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,40,0' classid='clsid:d27cdb6e-ae6d-11cf-96b8-444553540000'>
        <param value='true' name='allowFullScreen'/><param name='wmode' value='opaque'>
        <param value='#{ url_player_video url_video }&rel=0&color1=0x3a3a3a&color2=0x999999&hl=#{ I18n.locale.to_s.downcase }&feature=player_embedded&fs=1' name='src'/>
        <embed width='640' height='385' wmode='opaque' allowfullscreen='true' src='#{ url_player_video url_video  }&rel=0&color1=0x3a3a3a&color2=0x999999&hl=#{ I18n.locale.to_s.downcase }&feature=player_embedded&fs=1' type='application/x-shockwave-flash'/></object>
			"		
	end

	def url_player_video url
		"http://www.youtube.com/v/#{ id_video( url ) }"
	end
	
	def id_video url
		url.to_s
		url.gsub(/.+v=/,nil.to_s).gsub(/&.+/,nil.to_s)
	end
	
	def id_photo url
		url = url.to_s
		url.gsub('http://','').gsub(/farm[0-9]\./,'').gsub('static.flickr.com/','').gsub('_s.jpg','')
	end

	def medium_photo_url url
		url.to_s.gsub('_s.jpg','')+'.jpg'
	end

	def author_photo name_author = ""				
		name_author = name_author.to_s
		if name_author.match(/\(.+\)/)
			real_author = name_author.match(/\(.+\)/)[0]
			name_author = real_author.gsub!( /(\(|\))/  , "")
		end 
		name_author
	end
	
	def auto_link_truncate text
		auto_link( text ){|_text| truncate(_text, :length => 40)}
	end
end
