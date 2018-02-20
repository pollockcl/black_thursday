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
    skip
    assert_equal 4985, @iir.all.size
  end
end
