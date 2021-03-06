require_relative 'test_helper'
require_relative '../lib/transaction_repository'
class TransactionRepositoryTest < MiniTest::Test
  def setup
    @file = './data/transactions.csv'
    @tr = TransactionRepository.new(@file, nil)
  end

  def test_existence
    assert_instance_of TransactionRepository, @tr
  end

  def test_all_method
    assert_equal 99, @tr.all.size
  end

  def test_find_by_id_method
    assert_nil @tr.find_by_id(-1)
    assert_equal 'failed', @tr.find_by_id(466).result
  end

  def test_find_by_invoice_id_method
    assert_nil @tr.find_all_by_invoice_id(-2).first
    assert_equal 1, @tr.find_all_by_invoice_id(512).size
  end
end
