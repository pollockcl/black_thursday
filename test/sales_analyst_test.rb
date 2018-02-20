require_relative 'test_helper'
require './lib/sales_engine'
require './lib/sales_analyst'
class SalesAnalystTest < MiniTest::Test
  def setup
    file = { items: './data/items.csv',
             merchants: './data/merchants.csv',
             invoices: './data/invoices.csv' }

    @se = SalesEngine.from_csv(file)
    @sa = SalesAnalyst.new(@se)
  end

  def test_existence

    assert_instance_of SalesAnalyst, @sa
  end

  def test_average_items_per_merchant
    assert_equal 2.88, @sa.average_items_per_merchant
  end

  def test_average_items_per_merchant_standard_deviation
    assert_equal 3.26, @sa.average_items_per_merchant_standard_deviation
  end

  def test_merchants_with_high_item_count_method
    assert_instance_of Array, @sa.merchants_with_high_item_count
    assert_instance_of Merchant, @sa.merchants_with_high_item_count[0]
    assert_equal 52, @sa.merchants_with_high_item_count.size
  end

  def test_average_item_price_for_merchant_method
    actual1 = @sa.average_item_price_for_merchant(12_334_105)
    actual2 = @sa.average_item_price_for_merchant(12_334_112)

    assert_instance_of BigDecimal, actual1
    assert_equal 16.66, actual1
    assert_equal 15.0, actual2
  end

  def test_average_average_price_per_merchant_method
    assert_equal 350.29, @sa.average_average_price_per_merchant
  end

  def test_golden_items
    assert_instance_of Array, @sa.golden_items
    assert_equal 5, @sa.golden_items.size
    assert_instance_of Item, @sa.golden_items[0]
  end

  def test_average_invoices_per_merchant_method
    assert_equal 10.49, @sa.average_invoices_per_merchant
  end

  def test_average_invoices_per_merchant_standard_deviation_method
    assert_equal 3.29, @sa.average_invoices_per_merchant_standard_deviation
  end

  def test_top_merchants_by_invoice_count_method
    assert_instance_of Array, @sa.top_merchants_by_invoice_count
    assert_instance_of Merchant, @sa.top_merchants_by_invoice_count.first
  end

  def test_bottom_merchants_by_invoice_count_method
    assert_instance_of Array, @sa.bottom_merchants_by_invoice_count
    assert_instance_of Merchant, @sa.bottom_merchants_by_invoice_count.first
  end

  def test_top_days_by_invoice_count
    assert_instance_of Array, @sa.top_days_by_invoice_count
  end
end
