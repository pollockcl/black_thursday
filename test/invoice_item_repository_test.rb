require_relative 'test_helper'
require_relative '../lib/invoice_item_repository'
# Tests for the InvoiceItemRepository class
class InvoiceItemRepositoryTest < MiniTest::Test
  def setup
    @file = './data/invoice_items.csv'

    @iir = InvoiceItemRepository.new(@file, nil)
  end

  def test_existence
    assert_instance_of InvoiceItemRepository, @iir
  end

  def test_all
    assert_equal 21_830, @iir.all.size
  end

  def test_find_by_id
    assert_nil @iir.find_by_id(-1)
    assert_instance_of InvoiceItem, @iir.find_by_id(2)
  end

  def test_find_all_by_item_id
    assert_equal [], @iir.find_all_by_item_id(-1)
    assert_equal 18, @iir.find_all_by_item_id(263_395_237).size
    assert_equal 13, @iir.find_all_by_item_id(263_395_721).size
  end

  def test_find_all_by_invoice_id
    assert_equal [], @iir.find_all_by_invoice_id(-1)
    assert_equal 3, @iir.find_all_by_invoice_id(9).size
    assert_equal 5, @iir.find_all_by_invoice_id(10).size
  end
end
