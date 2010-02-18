module TagHelper
	
	def embed_video url_video
		id_video = id_video url_video		
		"<object width='640' height='385' codebase='http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,40,0' classid='clsid:d27cdb6e-ae6d-11cf-96b8-444553540000'>
        <param value='true' name='allowFullScreen'/><param name='wmode' value='opaque'>
        <param value='http://www.youtube.com/v/#{ id_video }&rel=0&color1=0xb1b1b1&color2=0xcfcfcf&hl=en&feature=player_embedded&fs=1' name='src'/>
        <embed width='640' height='385' wmode='opaque' allowfullscreen='true' src='http://www.youtube.com/v/#{ id_video }&rel=0&color1=0xb1b1b1&color2=0xcfcfcf&hl=en&feature=player_embedded&fs=1' type='application/x-shockwave-flash'/></object>
			"			
	end

	def id_video url
		url.gsub(/.+v=/,nil.to_s).gsub(/&.+/,nil.to_s)
	end

	def id_photo url
		url.gsub('http://','').gsub(/farm[0-9]\./,'').gsub('static.flickr.com/','').gsub('_s.jpg','')
	end

	def medium_photo_url url
		url.gsub('_s.jpg','')+'.jpg'
	end

end
