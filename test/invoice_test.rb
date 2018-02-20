require_relative 'test_helper'
require_relative '../lib/invoice.rb'
class InvoiceTest < MiniTest::Test
  def setup
    @attributes = {id:          6,
                   customer_id: 7,
                   merchant_id: 8,
                   status:     :pending,
                   created_at: Time.now,
                   updated_at: Time.now,
                   parent: nil}
  end

  def test_existence
    invoice = Invoice.new(@attributes)

    assert_instance_of Invoice, invoice
  end
end
