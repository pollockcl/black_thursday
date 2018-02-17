require 'test/test_helper'
require './lib/merchant'
class MerchantTest < MiniTest::Test
  def test_existence
    merchant = Merchant.new(1, 'Bobby')

    assert_instance_of Merchant, merchant
  end