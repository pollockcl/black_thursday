require_relative './test_helper'
require './lib/invoice_item'
require 'bigdecimal'

# Tests for the InvoiceItem class
class InvoiceItemTest < MiniTest::Test
  def setup
    @attributes = { id:         1,
                    item_id:    263_519_844,
                    invoice_id: 1,
                    quantity:   4,
                    unit_price: BigDecimal.new(10.99, 4),
                    created_at: Time.now,
                    updated_at: Time.now,
                    parent: nil }
  end

  def test_existence
    item = InvoiceItem.new(@attributes)

    assert_instance_of InvoiceItem, item
  end

  def test_attributes
    invoice_item = InvoiceItem.new(@attributes)

    assert_equal 1, invoice_item.id
    assert_equal 263_519_844, invoice_item.item_id
    assert_equal 10.99, invoice_item.unit_price
  end

  def test_unit_price_to_dollars
    item = InvoiceItem.new(@attributes)

    assert_equal 10.99, item.unit_price_to_dollars
  end
end
