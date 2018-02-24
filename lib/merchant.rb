# This is the Merchant class
class Merchant
  attr_reader :id, :name, :created_at
  def initialize(attributes)
    @id         = attributes[:id].to_i
    @name       = attributes[:name]
    @parent     = attributes[:parent]
    @created_at = attributes[:created]
  end

  def items
    @parent.parent.items.find_all_by_merchant_id(id)
  end

  def invoices
    @parent.parent.invoices.find_all_by_merchant_id(id)
  end

  def customers
    merchant_invoices = @parent.parent.invoices.find_all_by_merchant_id(id)
    merchant_invoices.map do |invoice|
      @parent.parent.customers.find_by_id(invoice.customer_id)
    end.uniq
  end
end
