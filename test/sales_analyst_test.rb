require_relative 'test_helper'
require './lib/sales_analyst'

class SalesAnalystTest < MiniTest::Test
  def setup
    file = { items: './data/items.csv',
             merchants: './data/merchants.csv' }

    @se = SalesEngine.from_csv(file)
  end

  def test_existence
    sa = SalesAnalyst.new(@se)

    assert_instance_of SalesAnalyst, sa
  end

  def test_average_items_per_merchant
    sa = SalesAnalyst.new(@se)
    expected = (@se.items.all.size / @se.merchants.all.size)

    assert_equal expected, sa.average_items_per_merchant
  end

  def test_average_items_per_merchant_standard_deviation
    sa = SalesAnalyst.new(@se)

    assert_equal 3.32, sa.average_items_per_merchant_standard_deviation
  end
end
