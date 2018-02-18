require_relative 'test_helper'
require './lib/sales_engine'
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

    assert_equal 3.38, sa.average_items_per_merchant_standard_deviation
  end

  def test_merchants_with_high_item_count_method
    sa = SalesAnalyst.new(@se)

    assert_instance_of Merchant, sa.merchants_with_high_item_count[0]
    assert_equal 114, sa.merchants_with_high_item_count.size
  end

  def test_total_units_for_merchant_method
    sa = SalesAnalyst.new(@se)

    assert_instance_of BigDecimal, sa.total_units_for_merchant(12_334_105)
    assert_equal 3, sa.total_units_for_merchant(12_334_105)
  end

  def test_sum_unit_prices_for_merchant_method
    sa = SalesAnalyst.new(@se)

    assert_instance_of BigDecimal, sa.sum_unit_prices_for_merchant(12_334_105)
    assert_equal 4_997, sa.sum_unit_prices_for_merchant(12_334_105)
  end

  def test_average_item_price_for_merchant_method
    sa = SalesAnalyst.new(@se)
    actual = sa.average_item_price_for_merchant(12_334_105)

    assert_instance_of BigDecimal, actual
    assert_equal 1_665.67, actual.round(2)
  end
end
