require_relative 'test_helper'
class DataAnalystTest < MiniTest::Test

  def test_existence
    da = DataAnalyst.new

    assert_instance_of DataAnalyst, da
  end

end