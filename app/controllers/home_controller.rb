# -*- encoding : utf-8 -*-
class HomeController < ApplicationController
	
	skip_before_filter :check_format
	caches_page :index
	
  def index	
		respond_to do |format|			
	    	format.xhtml{ 
					@data = Home.all
					@spotlight = Tag.all_rss("cancaonova")[0...10]
				}
		    format.rss	{ 
					@tag = "cancaonova" if @tag.empty? 
					redirect_to :controller => "tag", :tag=> @tag, :format => params[:format] 
				}
		    format.mrss	{ 
					@tag = "cancaonova" if @tag.empty? 
					redirect_to :controller => "tag", :tag=> @tag, :format => params[:format] 
				}
	    	format.any	{ 
					params[:format] = "html"
					@data = Home.all
					@spotlight = Tag.all_rss("cancaonova")[0...10]
				}
		  end		
  end
		
end

