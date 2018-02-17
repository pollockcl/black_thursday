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
    assert_equal nil, @ir.find_by_id(-1)
    assert_instance_of Item, @ir.find_by_id(263395237)
  end
end
