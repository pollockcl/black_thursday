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

  def test_average_items_per_merchang
    sa = SalesAnalyst.new(@se)

    assert_equal (@se.items.all.size / @se.merchants.all.size), sa.average_items_per_merchant
  end
end
