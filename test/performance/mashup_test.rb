require 'test_helper'
require 'performance_test_help'

class MashupTest < ActionController::PerformanceTest

  def test_blog
    get '/mashup/blog'
  end

  def test_bookmark
    get '/mashup/bookmark'
  end

  def test_video
    get '/mashup/video'
  end

  def test_photo
    get '/mashup/photo'
  end

  def test_photo
    get '/mashup/microtext'
  end

  def test_mashup
    get '/mashup'
  end

end
