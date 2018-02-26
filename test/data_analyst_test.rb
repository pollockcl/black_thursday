require_relative 'test_helper'
require './lib/data_analyst'
class DataAnalystTest < MiniTest::Test
  def test_find_attributes
    file = './data/merchants.csv'

    assert_instance_of CSV::Table, DataAnalyst.find_attributes(file)
  end
end
