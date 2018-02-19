# Tests for the SalesEngine class
require './test/test_helper'
require './lib/sales_engine'
class SalesEngineTest < MiniTest::Test
  def setup
    @files = { items: './data/items.csv',
               merchants: './data/merchants.csv',
               invoices: './data/invoices.csv' }
    @se             = SalesEngine.from_csv(@files)
    @merchant_repo  = @se.merchants
    @item_repo      = @se.items
  end

  def test_from_csv_method_and_existance
    se = SalesEngine.from_csv(@files)

    assert_instance_of SalesEngine, se
  end

  def test_has_merch_and_items
    se = SalesEngine.from_csv(@files)

    assert_instance_of ItemRepository, se.items
    assert_instance_of MerchRepository, se.merchants
  end

  def test_items_method
    merchant = @merchant_repo.find_by_id(12_334_478)

    assert_equal 7, merchant.items.size
    assert_instance_of Item, merchant.items[0]
  end

  def test_merchants_method
    item = @item_repo.find_by_id(263_420_195)

    assert_equal 'DenesDoorDecor', item.merchant.name
  end
end
