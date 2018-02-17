require_relative 'test_helper'
require './lib/data_analyst'
class DataAnalystTest < MiniTest::Test
  def test_find_merchants
    file = './data/merchants.csv'  

    assert_instance_of Array, DataAnalyst.find_merchants(file)
  end

  def test_find_items
    file = './data/items.csv'

    assert_instance_of Array, DataAnalyst.find_items(file)
  end
end
