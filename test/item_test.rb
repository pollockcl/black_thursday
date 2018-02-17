require_relative './test_helper'
require './lib/item.rb'
require 'bigdecimal'

class ItemTest < MiniTest::Test
  def test_existence
    item = Item.new(1,"Pencil", "You can use it to write things", BigDecimal.new(10.99,4), 1, Time.now, Time.now)

    assert_instance_of Item, item
  end

  def test_attributes
    item = Item.new(1,"Pencil", "You can use it to write things", BigDecimal.new(10.99,4), 1, Time.now, Time.now)

    assert_equal 'Pencil', item.name
    assert_equal 'You can use it to write things', item.description
  end
end