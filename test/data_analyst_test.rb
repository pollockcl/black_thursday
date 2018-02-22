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

  def test_find_transactions
    file = './data/transactions.csv'

    assert_instance_of Array, DataAnalyst.find_transactions(file)
  end

  def test_find_customers
    file = './data/customers.csv'

    assert_instance_of Array, DataAnalyst.find_customers(file)
  end

  def test_find_invoices
    file = './data/invoices.csv'

    assert_instance_of Array, DataAnalyst.find_invoices(file)
  end

  def test_find_invoice_items
    file = './data/invoice_items.csv'

    assert_instance_of Array, DataAnalyst.find_invoice_items(file)
  end
end
