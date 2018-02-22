require_relative 'test_helper'
require_relative '../lib/invoice_repository'
class InvoiceRepositoryTest < MiniTest::Test
  def setup
    @file = './data/invoices.csv'

    @inv_repo = InvoiceRepository.new(@file, nil)
  end

  def test_existence
    assert_instance_of InvoiceRepository, @inv_repo
  end

  def test_all
    assert_equal 99, @inv_repo.all.size
  end

  def test_find_by_id
    assert_nil @inv_repo.find_by_id(-1)
    assert_instance_of Invoice, @inv_repo.find_by_id(502)
  end

  def test_find_all_by_customer_id
    assert_equal [], @inv_repo.find_all_by_customer_id(103)
    assert_instance_of Invoice, @inv_repo.find_all_by_customer_id(11).first
    assert_equal 4, @inv_repo.find_all_by_customer_id(2).size
  end

  def test_find_all_by_merchant_id
    assert_equal 1, @inv_repo.find_all_by_merchant_id(201).size
    assert_equal [], @inv_repo.find_all_by_merchant_id(-1)
  end

  def test_find_all_by_status
    assert_equal 62, @inv_repo.find_all_by_status('shipped').size
    assert_equal 29, @inv_repo.find_all_by_status('pending').size
    assert_equal 8, @inv_repo.find_all_by_status('returned').size
  end
end
