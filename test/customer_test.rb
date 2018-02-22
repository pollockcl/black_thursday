require_relative 'test_helper'
require_relative '../lib/customer'
class CustomerTest < MiniTest::Test
  def setup
    @attributes = { id: 6,
                    first: 'Joan',
                    last:  'Clarke',
                    created: Time.now,
                    updated: Time.now,
                    parent:     nil }
  end

  def test_existence
    customer = Customer.new(@attributes)

    assert_instance_of Customer, customer
  end

  def test_attributes
    customer = Customer.new(@attributes)

    assert_equal 6, customer.id
    assert_equal 'Joan', customer.first_name
    assert_equal 'Clarke', customer.last_name
    assert_instance_of Time, customer.created_at
    assert_instance_of Time, customer.updated_at
  end
end
