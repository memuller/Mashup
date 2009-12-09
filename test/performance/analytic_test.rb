require 'test_helper'
require 'performance_test_help'

class BlogTest < ActionController::PerformanceTest

  def test_homepage
    get '/blog'
  end

end
