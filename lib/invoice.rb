# This is the Invoice class
class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at
  def initialize(attributes)
    @id          = attributes[:id].to_i
    @customer_id = attributes[:customer_id].to_i
    @merchant_id = attributes[:merchant_id].to_i
    @status      = attributes[:status]
    @created_at  = attributes[:created_at]
    @updated_at  = attributes[:updated_at]
    @parent      = attributes[:parent]
  end

  def weekday_created
    Time.parse(@created_at).strftime('%A')
  end
end
