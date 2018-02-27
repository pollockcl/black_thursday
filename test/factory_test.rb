require_relative 'test_helper'
require './lib/factory'
class FactoryTest < MiniTest::Test
  def test_find_attributes
    file = './data/merchants.csv'

    assert_instance_of CSV::Table, Factory.find_attributes(file)
  end
end
