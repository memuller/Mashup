require 'test_helper'
require 'performance_test_help'

class HomeTest < ActionController::PerformanceTest

  def test_homepage
    get '/'
  end

end
