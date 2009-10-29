class BlogController < ApplicationController
	
  def index	
		@blogs = Blog.all(params[:page])
		
		respond_to do |wants|
			wants.html 
			wants.atom
			wants.xml { render :xml => @blogs.entries}
		end
  end

  def show	
		@blogs = Blog.all(params[:tags], params[:page])
		
		respond_to do |wants|
			wants.html 
			wants.xml { render :xml => @blogs.entries}
			wants.atom
		end
  end

end
