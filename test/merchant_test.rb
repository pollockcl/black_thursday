require_relative 'test_helper'
require './lib/merchant'
class MerchantTest < MiniTest::Test
  def test_existence
    merchant = Merchant.new(1, 'Bobby')

    assert_instance_of Merchant, merchant
  end

  def test_attributes
    merchant = Merchant.new(1, 'Bobby')

    assert_equal 1, merchant.id
    assert_equal 'Bobby', merchant.name
  end
end
