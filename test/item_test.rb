require_relative './test_helper'
require './lib/item.rb'
require 'bigdecimal'

class ItemTest < MiniTest::Test
  def test_existence
    item = Item.new(1, 'Pencil', 'You can use it to write things', BigDecimal.new(10.99, 4), 1, Time.now, Time.now, nil)

    assert_instance_of Item, item
  end

  def test_attributes
    item = Item.new(1, 'Pencil', 'You can use it to write things', BigDecimal.new(10.99, 4), 1, Time.now, Time.now, nil)

    assert_equal 'Pencil', item.name
    assert_equal 1, item.id
    assert_equal 1, item.merchant_id
    assert_equal 'You can use it to write things', item.description
  end

  def test_price_to_dollars
    item = Item.new(1, 'Pencil', 'You can use it to write things', BigDecimal.new(10.99, 4), 1, Time.now, Time.now, nil)

    assert_equal 10.99, item.unit_price_to_dollars
  end
end
