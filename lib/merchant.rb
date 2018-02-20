# This is the Merchant class
class Merchant
  attr_reader :id, :name
  def initialize(attributes)
    @id     = attributes[:id].to_i
    @name   = attributes[:name]
    @parent = attributes[:parent]
  end

  def items
    @parent.parent.items.find_all_by_merchant_id(@id)
  end

  def invoices
    @parent.parent.invoices.find_all_by_merchant_id(@id)
  end
end
