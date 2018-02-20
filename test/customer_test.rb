require_relative 'test_helper'
require_relative '../lib/customer'
class CustomerTest < MiniTest::Test
  def setup
    @attributes = { id: 6,
                    first_name: 'Joan',
                    last_name:  'Clarke',
                    created_at: Time.now,
                    updated_at: Time.now,
                    parent:     nil }
  end

  def test_existence
    customer = Customer.new(@attributes)

    assert_instance_of Customer, customer
  end
end
