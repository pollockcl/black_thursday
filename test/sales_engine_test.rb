# Tests for the SalesEngine class
require './test/test_helper'
require './lib/sales_engine'
class SalesEngineTest < MiniTest::Test
  def setup
    @files = { items:         './data/items.csv',
               merchants:     './data/merchants.csv',
               invoices:      './data/invoices.csv',
               invoice_items: './data/invoice_items.csv',
               transactions: './data/transactions.csv',
               customers: './data/customers.csv' }
    @se             = SalesEngine.from_csv(@files)
    @merchant_repo  = @se.merchants
    @item_repo      = @se.items
    @inv_repo       = @se.invoices
    @inv_item_repo  = @se.invoice_items
    @trans_repo     = @se.transactions
    @cust_repo      = @se.customers
  end

  def test_from_csv_method_and_existance
    assert_instance_of SalesEngine, @se
  end

  def test_has_merch_and_items_and_invoices_and_invoice_items
    assert_instance_of ItemRepository, @se.items
    assert_instance_of MerchRepository, @se.merchants
    assert_instance_of InvoiceRepository, @se.invoices
    assert_instance_of InvoiceItemRepository, @se.invoice_items
  end

  def test_items_method
    merchant = @merchant_repo.find_by_id(204)

    assert_equal 1, merchant.items.size
    assert_instance_of Item, merchant.items[0]
  end

  def test_merchants_method
    item = @item_repo.find_by_id(194)

    assert_equal 'FrenchiezShop', item.merchant.name
  end

  def test_invoice_merchant_method
    assert_instance_of Merchant, @inv_repo.all.first.merchant
  end

  def test_merchant_invoices_method
    assert_instance_of Invoice, @merchant_repo.all.first.invoices.first
  end

  def test_invoices_items_method
    assert_instance_of Item, @inv_repo.all.first.items.first
    assert_equal 1, @inv_repo.all.first.items.size
  end

  def test_invoices_invoice_items
    assert_instance_of InvoiceItem, @inv_repo.all.first.invoice_items.first
  end

  def test_invoices_transaction_method
    assert_instance_of Transaction, @inv_repo.all.first.transactions.first
    assert_equal 1, @inv_repo.all.first.transactions.size
  end

  def test_invoices_is_paid_in_full_method
    assert @inv_repo.all.first.is_paid_in_full?
    refute @inv_repo.find_by_id(509).is_paid_in_full?
  end

  def test_invoices_total_method
    assert_equal 681.75, @inv_repo.all.first.total
  end

  def test_invoices_customer_method
    assert_instance_of Customer, @inv_repo.all.first.customer
  end

  def test_transaction_invoice_method
    assert_instance_of Invoice, @trans_repo.all.first.invoice
  end

  def test_merchant_customers_method
    assert_instance_of Customer, @merchant_repo.all.first.customers.first
  end

  def test_merchant_items_method
    assert_instance_of Item, @merchant_repo.all.first.items.first
  end

  def test_merchant_invoices_method
    assert_instance_of Invoice, @merchant_repo.all.first.invoices.first
  end  

  def test_transaction_repository_find_all_by_result_method
    assert_instance_of Transaction, @trans_repo.find_all_by_result('success').first
  end

  def test_transaction_repository_find_all_by_credit_card_number
    assert_instance_of Transaction, @trans_repo.find_all_by_credit_card_number(4068631943231473).first
  end
end
