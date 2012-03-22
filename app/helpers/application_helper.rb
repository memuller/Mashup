# -*- encoding : utf-8 -*-
# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

	def image_tag_avatar img 
			image_tag( img[6], :class => "avatar", :width => "48", :height => "48" ) if microblog?( img[7]) && img[6].nil? != true		
	end

	def microblog? item
		item == "microblog"
	end

	def blog? item
		item == "blog"
	end

	def news? item
		item == "news"
	end
	
	def photo? item
		item == "photo"
	end
	
	def video? item
		item == "video"
	end
	
	def tag_nil?
		 (@tag.empty?)? "cancaonova" : @tag
	end
end
