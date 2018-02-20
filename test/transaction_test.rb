require_relative 'test_helper'
require_relative '../lib/transaction.rb'
class TransactionTest < MiniTest::Test
  def setup
    @attributes = {}
  end

  def test_existence
    transaction = Transaction.new(@attributes)

    assert_instance_of Transaction, transaction
  end
end
