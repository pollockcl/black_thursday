require_relative 'test_helper'
require_relative '../lib/customer_repository'
class CustomerRepositoryTest < MiniTest::Test
  def setup
    @customer_1 = Customer.new(id: 1, first: 'Darth', last: 'Plagueis', created: Time.now, updated: Time.now)
    @customer_2 = Customer.new(id: 2, first: 'Obi', last: 'Kenobi', created: Time.now, updated: Time.now)
    @customer_3 = Customer.new(id: 3, first: 'Count', last: 'Dooku', created: Time.now, updated: Time.now)
    @cr = CustomerRepository.new([@customer_1, @customer_2, @customer_3], nil)
  end

  def test_existence
    assert_instance_of CustomerRepository, @cr
  end

  def test_all_method
    assert_instance_of Customer, @cr.all.first
    assert_equal 3, @cr.all.size
  end

  def test_find_by_id_method
    assert_nil @cr.find_by_id(-1)
    assert_equal 'Kenobi', @cr.find_by_id(2).last_name
  end

  def test_find_all_by_first_name_method
    assert_equal [@customer_1], @cr.find_all_by_first_name('Darth')
    assert_equal [], @cr.find_all_by_first_name('As')
  end

  def test_find_all_by_last_name
    assert_equal [@customer_1], @cr.find_all_by_last_name('Plagueis')
    assert_equal 2, @cr.find_all_by_last_name('e').size
  end
end
