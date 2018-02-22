require_relative 'test_helper'
require './lib/sales_engine'
require './lib/sales_analyst'
class SalesAnalystTest < MiniTest::Test
  def setup
    file = { items: './data/items.csv',
             merchants: './data/merchants.csv',
             invoices: './data/invoices.csv',
             invoice_items: './data/invoice_items.csv',
             transactions: './data/transactions.csv',
             customers: './data/customers.csv' }

    @se = SalesEngine.from_csv(file)
    @sa = SalesAnalyst.new(@se)
  end

  def test_existence
    skip
    assert_instance_of SalesAnalyst, @sa
  end

  def test_average_items_per_merchant
    skip
    assert_equal 2.88, @sa.average_items_per_merchant
  end

  def test_average_items_per_merchant_standard_deviation
    skip
    assert_equal 3.26, @sa.average_items_per_merchant_standard_deviation
  end

  def test_merchants_with_high_item_count_method
    skip
    assert_instance_of Array, @sa.merchants_with_high_item_count
    assert_instance_of Merchant, @sa.merchants_with_high_item_count[0]
    assert_equal 52, @sa.merchants_with_high_item_count.size
  end

  def test_average_item_price_for_merchant_method
    skip
    actual1 = @sa.average_item_price_for_merchant(12_334_105)
    actual2 = @sa.average_item_price_for_merchant(12_334_112)

    assert_instance_of BigDecimal, actual1
    assert_equal 16.66, actual1
    assert_equal 15.0, actual2
  end

  def test_average_average_price_per_merchant_method
    skip
    assert_equal 350.29, @sa.average_average_price_per_merchant
  end

  def test_golden_items
    skip
    assert_instance_of Array, @sa.golden_items
    assert_equal 5, @sa.golden_items.size
    assert_instance_of Item, @sa.golden_items[0]
  end

  def test_average_invoices_per_merchant_method
    skip
    assert_equal 10.49, @sa.average_invoices_per_merchant
  end

  def test_average_invoices_per_merchant_standard_deviation_method
    skip
    assert_equal 3.29, @sa.average_invoices_per_merchant_standard_deviation
  end

  def test_top_merchants_by_invoice_count_method
    skip
    assert_instance_of Array, @sa.top_merchants_by_invoice_count
    assert_instance_of Merchant, @sa.top_merchants_by_invoice_count.first
  end

  def test_bottom_merchants_by_invoice_count_method
    skip
    assert_instance_of Array, @sa.bottom_merchants_by_invoice_count
    assert_instance_of Merchant, @sa.bottom_merchants_by_invoice_count.first
  end

  def test_top_days_by_invoice_count
    skip
    assert_instance_of Array, @sa.top_days_by_invoice_count
    assert_equal 'Wednesday', @sa.top_days_by_invoice_count.first
  end

  def test_invoice_status_method
    skip
    assert_equal 29.55, @sa.invoice_status('pending')
    assert_equal 56.95, @sa.invoice_status('shipped')
    assert_equal 13.5,  @sa.invoice_status('returned')
  end

  def test_std_deviation_daily_invoices_method
    skip
    assert_equal 18.07, @sa.std_deviation_daily_invoices.round(2)
  end

  def test_find_days_method
    skip
    assert_instance_of Hash, @sa.find_days
    assert_equal 7, @sa.find_days.size
  end

  def test_average_daily_invoices
    skip
    assert_equal 712, @sa.average_daily_invoices.to_i
  end

  def test_invoices_method
    skip
    assert_instance_of Invoice, @sa.invoices.first
  end

  def test_items_method
    skip
    assert_instance_of Item, @sa.items.first
  end

  def test_merchants_method
    skip
    assert_instance_of Merchant, @sa.merchants.first
  end

  def test_total_revenue_by_date
    assert_equal 21067.77, @sa.total_revenue_by_date("2009-02-07")
  end
end
