require_relative './test_helper'
require './lib/item.rb'

class ItemTest < Test::MiniTest
  def test_existence
    item = Item.new("Pencil", "You can use it to write things", BigDecimal.new(10.99,4), Time.now, Time.now})

    assert_instance_of Item, item
  end

  def test_attributes
    item = Item.new("Pencil", "You can use it to write things", BigDecimal.new(10.99,4), Time.now, Time.now})

    assert_equal 'Pencil', item.name
    assert_equal 'You can use it to write things', item.description
  end
end