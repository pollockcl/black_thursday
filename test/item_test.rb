require_relative './test_helper'
require './lib/item'
require 'bigdecimal'

class ItemTest < MiniTest::Test
  def setup
    @attributes = { id: 1,
                    name: 'Pencil',
                    description: 'You can use it to write things',
                    unit_price: BigDecimal.new(10.99, 4),
                    merchant_id: 1,
                    created_at: Time.now,
                    updated_at: Time.now,
                    parent: nil }
  end

  def test_existence
    item = Item.new(@attributes)

    assert_instance_of Item, item
  end

  def test_attributes
    item = Item.new(@attributes)

    assert_equal 'Pencil', item.name
    assert_equal 1, item.id
    assert_equal 1, item.merchant_id
    assert_equal 'You can use it to write things', item.description
  end

  def test_price_to_dollars
    item = Item.new(@attributes)

    assert_equal 10.99, item.unit_price_to_dollars
  end
end
