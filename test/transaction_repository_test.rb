require_relative 'test_helper'
require_relative '../lib/transaction_repository'
class TransactionRepositoryTest < MiniTest::Test
  def setup
    @tr  = TransactionRepository.new
    @csv = './data/transactions.csv'
    @tr.from_csv(@csv)
  end

  def test_existence
    assert_instance_of TransactionRepository, @tr
  end
end
