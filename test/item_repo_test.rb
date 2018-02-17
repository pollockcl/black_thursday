require './test/test_helper'
require './lib/item_repo'
class ItemRepoTest < MiniTest::Test
  def setup
    csv = './data/items.csv'
    @ir = ItemRepo.new(csv)
  end

  def test_existence
    assert_instance_of ItemRepo, @ir
  end

  def test_all
    assert_equal 1367, @ir.all.size
  end

  def test_find_by_id
    assert_nil @ir.find_by_id(-1)
    assert_instance_of Item, @ir.find_by_id(263395237)
  end

  def test_find_by_name
    assert_nil @ir.find_by_name('Farquad')
    assert_instance_of Item, @ir.find_by_name('Le corps et la chauffeuse')
  end

  def test_find_all_with_description
    assert_equal 4, @ir.find_all_with_description('A4 or A5 prints available').size
    assert_equal [], @ir.find_all_with_description('Did you ever hear the tragedy of...')
  end

  def test_find_all_by_price
    assert_equal 2, @ir.find_all_by_price(120000).size
    assert_equal [], @ir.find_all_by_price(0)
  end
end
