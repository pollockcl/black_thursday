# Tests for the SalesEngine class
require './test/test_helper'
require './lib/sales_engine'
class SalesEngineTest < MiniTest::Test
  def setup
    @files = {:items     => "./data/items.csv",
              :merchants => "./data/merchants.csv"}

  end
  
  def test_from_csv_method_and_existance
    se = SalesEngine.from_csv(@files)

    assert_instance_of SalesEngine, se
  end

  def test_has_merch_and_items
    se = SalesEngine.from_csv(@files)
    
    assert_instance_of ItemRepo, se.items
    assert_instance_of MerchRepo, se.merchants
  end
end
