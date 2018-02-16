require './test/test_helper'
require './lib/sales_engine'

class SalesEngineTest < MiniTest::Test

  def test_existence
    se = SalesEngine.new

    assert_instance_of SalesEngine, se
  end


end