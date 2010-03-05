# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

	def image_tag_avatar img 
			image_tag( img[6], :class => "avatar", :width => "48", :height => "48" ) if twitter?( img[0]) && img[6].nil? == false		
	end

	def twitter? item
		item.include? "twitter.com" unless item.nil?
	end

	def news? item
		item.include? "twitter.com" unless item.nil?
	end
	
	def what_service? url
		if twitter? url 
			"microblog"
		end
	end
	
end
