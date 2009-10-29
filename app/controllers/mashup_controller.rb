class MashupController < ApplicationController

  def index
#		@mashup = Mashup.all

		@mashup =	{:blogs => Mashup.blog, 
			:bookmarks => Mashup.bookmark,
			:videos => Mashup.video,
			:photos => Mashup.photo,
			:microtexts => Mashup.microtext
							}

  end

  def video
		@videos = Mashup.video
  end

  def blog
		@blogs = Mashup.blogs
	end

  def photo
		@photos = Mashup.photo
  end

  def microtext
		@microtexts = Mashup.microtext
  end

  def bookmark
		@bookmarks = Mashup.bookmark
  end

end
