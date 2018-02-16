require './test/test_helper'
require './lib/item_repo'

class ItemRepoTest < MiniTest::Test
  def test_existence
    ir = ItemRepo.new

    assert_instance_of ItemRepo, ir
  end
end