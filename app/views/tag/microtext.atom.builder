atom_feed do |feed|
	render :partial => 'feed', :locals => {:feed => feed, :atom => @entries, :feed_title => "microtext"}
end