require_relative 'test_helper'
require_relative '../lib/customer_repository'
class CustomerRepositoryTest < MiniTest::Test
  def setup
    @cr  = CustomerRepository.new
    @csv = './data/customers.csv'
  end

  def test_existence
    assert_instance_of CustomerRepository, @cr
  end

  def test_from_csv_method_and_all_method
    @cr.from_csv(@csv)

    assert_instance_of Customer, @cr.all.first
    assert_equal 1_000, @cr.all.size
  end
end
