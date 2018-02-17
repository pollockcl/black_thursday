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

  def test_attributes
    assert_equal 1367, @ir.items.size
  end
end