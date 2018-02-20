require_relative 'test_helper'
require_relative '../lib/customer_repository'
class CustomerRepositoryTest < MiniTest::Test
  def setup
    @cr  = CustomerRepository.new
    @csv = './data/customers.csv'
    @cr.from_csv(@csv)
  end

  def test_existence
    assert_instance_of CustomerRepository, @cr
  end

  def test_all_method
    assert_instance_of Customer, @cr.all.first
    assert_equal 1_000, @cr.all.size
  end

  def test_find_by_id_method
    assert_nil @cr.find_by_id(-1)
    assert_equal 'Nader', @cr.find_by_id(66).last_name
  end
end
