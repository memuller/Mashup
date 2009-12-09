require 'test_helper'
require 'performance_test_help'

class TagTest < ActionController::PerformanceTest

  def test_home
    get '/'
  end

  def test_blog
    get '/blog'
  end

  def test_bookmark
    get '/bookmark'
  end

  def test_video
    get '/video'
  end

  def test_photo
    get '/photo'
  end

  def test_photo
    get '/microtext'
  end

  def test_mashup
    get '/mashup'
  end

end
