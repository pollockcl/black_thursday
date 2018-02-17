require './test/test_helper'
require './lib/merch_repo'

class MerchRepoTest < MiniTest::Test
  def setup
    csv = './data/merchants.csv'
    @mr = MerchRepo.new(csv)
  end
  
  def test_existence 
    assert_instance_of MerchRepo, @mr
  end

  def test_merchants
    assert_equal 475, @mr.merchants.size
  end
end