# This is the Invoice class
class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at
  def initialize(attributes)
    @id          = attributes[:id]
    @customer_id = attributes[:customer_id]
    @merchant_id = attributes[:merchant_id]
    @status      = attributes[:status]
    @created_at  = attributes[:created_at]
    @updated_at  = attributes[:updated_at]
    @parent      = attributes[:parent]
  end

  def merchant
    @parent.parent.merchants.find_by_id(@merchant_id)
  end

  def weekday_created
    @created_at.strftime('%A')
  end

  def items
    @parent.parent.invoice_items.find_all_by_invoice_id(@id)
  end

  def transactions
    @parent.parent.transactions.find_by_invoice_id(@id)
  end

  def customer
    @parent.parent.customers.find_by_id(@id)
  end

  def is_paid_in_full?
    transactions.map { |transaction| transaction.result }.include?('success')
  end

  def returned?
    @status == 'returned'
  end

  def total
    return 0 if !is_paid_in_full? || returned?
    items.map { |item| item.quantity * item.unit_price }.reduce(:+)
  end
end
