class VideoController < ApplicationController
  def index
		@videos = Feedzirra::Feed.fetch_and_parse("http://gdata.youtube.com/feeds/api/videos/?orderby=published&start-index=1&max-results=10&search=tag&category=dunga+cancaonova")		
  end

end
