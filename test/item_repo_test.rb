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
end
