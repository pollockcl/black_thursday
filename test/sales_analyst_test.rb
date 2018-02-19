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

    assert_equal 2.88, sa.average_items_per_merchant
  end

  def test_standard_deviation_items_per_merchant
    sa = SalesAnalyst.new(@se)

    assert_equal 3.26, sa.average_items_per_merchant_standard_deviation
  end

  def test_merchants_with_high_item_count_method
    sa = SalesAnalyst.new(@se)

    assert_instance_of Array, sa.merchants_with_high_item_count
    assert_instance_of Merchant, sa.merchants_with_high_item_count[0]
    assert_equal 52, sa.merchants_with_high_item_count.size
  end

  def test_average_item_price_for_merchant_method
    sa = SalesAnalyst.new(@se)
    actual_1 = sa.average_item_price_for_merchant(12334105).round(2)
    actual_2 = sa.average_item_price_for_merchant(12334112).round(2)

    assert_instance_of BigDecimal, actual_1
    assert_equal 1_665.67, actual_1
    assert_equal 1_500, actual_2
  end

  # # methods below need to be checked
  # def test_sum_average_item_prices_for_all_merchants
  #   skip # moved this method to arithmatic
  #   sa = SalesAnalyst.new(@se)

  #   assert_instance_of BigDecimal, sa.sum_average_item_prices_all_merchants
  #   # need more precise test using fixture
  # end

  # def test_average_average_prices_per_merchant
  #   skip
  #   sa = SalesAnalyst.new(@se)

  #   assert_instance_of BigDecimal, sa.average_average_item_prices_per_merchant
  #   assert_equal 0, sa.average_average_item_prices_per_merchant
  #   # need more precise test using fixture
  # end

  # def test_standard_deviation_average_average_item_prices_per_merchant
  #   skip
  #   sa = SalesAnalyst.new(@se)
  #   actual = sa.standard_deviation_avg_item_price

  #   assert_equal 0, actual
  # end

  # def test_golden_merchants
  #   skip
  #   sa = SalesAnalyst.new(@se)
  #   actual = sa.golden_items

  #   assert_equal 0, actual.size
  # end
end
