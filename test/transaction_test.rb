require_relative 'test_helper'
require_relative '../lib/transaction.rb'
class TransactionTest < MiniTest::Test
  def setup
    @attributes = { id:                          6,
                    invoice_id:                  8,
                    credit_card_number:          '4242424242424242',
                    credit_card_expiration_date: '0220',
                    result:                      'success',
                    created_at:                  Time.now,
                    updated_at:                  Time.now }
  end

  def test_existence
    transaction = Transaction.new(@attributes)

    assert_instance_of Transaction, transaction
  end
end
