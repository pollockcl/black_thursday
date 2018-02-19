require_relative 'test_helper'
require './lib/merchant'
class MerchantTest < MiniTest::Test
  def setup
    @attributes = { id: 1,
                    name: 'Bobby',
                    parent: nil }
  end
  def test_existence
    merchant = Merchant.new(@attributes)

    assert_instance_of Merchant, merchant
  end

  def test_attributes
    merchant = Merchant.new(@attributes)

    assert_equal 1, merchant.id
    assert_equal 'Bobby', merchant.name
  end
end
