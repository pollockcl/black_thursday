require './test/test_helper'
require './lib/merch_repo'

class MerchRepoTest < MiniTest::Test
  def test_existence
    mr = MerchRepo.new(csv)

    assert_instance_of MerchRepo, mr
  end
end