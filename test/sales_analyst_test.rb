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
    assert_instance_of SalesAnalyst, @sa
  end

  def test_average_items_per_merchant
    assert_equal 1.0, @sa.average_items_per_merchant
  end

  def test_average_items_per_merchant_standard_deviation
    assert_equal 0.0, @sa.average_items_per_merchant_standard_deviation
  end

  def test_merchants_with_high_item_count_method
    assert_instance_of Array, @sa.merchants_with_high_item_count
    assert_nil @sa.merchants_with_high_item_count.first
    assert_equal 0, @sa.merchants_with_high_item_count.size
  end

  def test_average_item_price_for_merchant_method
    actual1 = @sa.average_item_price_for_merchant(204)
    actual2 = @sa.average_item_price_for_merchant(290)

    assert_instance_of BigDecimal, actual1
    assert_equal 7, actual1
    assert_equal 75.0, actual2
  end

  def test_average_average_price_per_merchant_method
    assert_equal 149.81, @sa.average_average_price_per_merchant
  end

  def test_golden_items
    assert_instance_of Array, @sa.golden_items
    assert_equal 2, @sa.golden_items.size
    assert_instance_of Item, @sa.golden_items[0]
  end

  def test_average_invoices_per_merchant_method
    assert_equal 1.0, @sa.average_invoices_per_merchant
  end

  def test_average_invoices_per_merchant_standard_deviation_method
    assert_equal 0.0, @sa.average_invoices_per_merchant_standard_deviation
  end

  def test_top_merchants_by_invoice_count_method
    assert_instance_of Array, @sa.top_merchants_by_invoice_count
  end

  def test_bottom_merchants_by_invoice_count_method
    assert_instance_of Array, @sa.bottom_merchants_by_invoice_count
  end

  def test_top_days_by_invoice_count
    assert_instance_of Array, @sa.top_days_by_invoice_count
    assert_equal 'Friday', @sa.top_days_by_invoice_count.first
  end

  def test_invoice_status_method
    assert_equal 29.29, @sa.invoice_status(:pending)
    assert_equal 62.63, @sa.invoice_status(:shipped)
    assert_equal 8.08,  @sa.invoice_status(:returned)
  end

  def test_std_deviation_daily_invoices_method
    assert_equal 3.99, @sa.std_deviation_daily_invoices.round(2)
  end

  def test_find_days_method
    assert_instance_of Hash, @sa.find_days
    assert_equal 7, @sa.find_days.size
  end

  def test_average_daily_invoices
    assert_equal 14, @sa.average_daily_invoices.to_i
  end

  def test_invoices_method
    assert_instance_of Invoice, @sa.invoices.first
  end

  def test_items_method
    assert_instance_of Item, @sa.items.first
  end

  def test_merchants_method
    assert_instance_of Merchant, @sa.merchants.first
  end

  def test_total_revenue_by_date
    date = Time.parse('2009-02-07')
    assert_equal 681.75, @sa.total_revenue_by_date(date)
  end

  def test_merchants_ranked_by_revenue
    assert_instance_of Merchant, @sa.top_revenue_earners.first
    assert_equal 235, @sa.top_revenue_earners.first.id
    assert_equal 224, @sa.top_revenue_earners.last.id
  end

  def test_top_revenue_earners
    assert_instance_of Merchant, @sa.top_revenue_earners(5).first
    assert_equal 5, @sa.top_revenue_earners(5).size
    assert_equal 7, @sa.top_revenue_earners(7).size
    assert_equal 20, @sa.top_revenue_earners.size
  end

  def test_merchants_with_pending_invoices
    assert_instance_of Merchant, @sa.merchants_with_pending_invoices.first
  end

  # def test_total_item_quantity
  #   assert_instance_of Hash, @sa.item_quantities_by_merchant(201)
  #   assert_instance_of Integer, @sa.item_quantities_by_merchant(201)
  # end

  def test_most_sold_items
    assert_instance_of Item, @sa.most_sold_item_for_merchant(201).first
  end
end
