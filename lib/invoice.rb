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
end
