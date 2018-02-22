require './test/test_helper'
require './lib/item_repository'
class ItemRepositoryTest < MiniTest::Test
  def setup
    csv = './data/items.csv'
    @ir = ItemRepository.new(csv, nil)
  end

  def test_existence
    assert_instance_of ItemRepository, @ir
  end

  def test_all
    assert_equal 99, @ir.all.size
  end

  def test_find_by_id
    assert_nil @ir.find_by_id(-1)
    assert_instance_of Item, @ir.find_by_id(102)
  end

  def test_find_by_name
    assert_nil @ir.find_by_name('Farquad')
    assert_instance_of Item, @ir.find_by_name('Free standing Woden letters')
  end

  def test_find_all_with_description
    assert_equal 3, @ir.find_all_with_description("A4 or A5 prints available").size
    assert_equal [], @ir.find_all_with_description('Did you ever hear the tragedy of...')
  end

  def test_find_all_by_price
    assert_equal 5, @ir.find_all_by_price(25).size
    assert_equal [], @ir.find_all_by_price(0)
  end

  def test_find_all_by_price_in_range
    assert_equal 3, @ir.find_all_by_price_in_range(1..3).size
    assert_equal [], @ir.find_all_by_price_in_range(-1..-2)
  end

  def test_find_all_by_merchant_id
    assert_equal 1, @ir.find_all_by_merchant_id(209).size
    assert_equal [], @ir.find_all_by_merchant_id(-22)
  end
end
