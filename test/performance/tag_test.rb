require 'test_helper'
require 'performance_test_help'

class TagTest < ActionController::PerformanceTest

  def test_tag_index
    get '/cancaonova'
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

  def test_news
    get '/news'
  end

  def test_timeline
    get '/news'
  end

  def test_mrss
    get '/cancaonova.mrss'
  end

  def test_rss
    get '/cancaonova.rss'
  end

end
