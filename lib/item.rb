# This is the Item class
class Item
  attr_reader :id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at, :parent
  def initialize(hash)
    @id          = hash[:id]
    @name        = hash[:name]
    @description = hash[:description]
    @unit_price  = hash[:unit_price]
    @merchant_id = hash[:merchant_id]
    @created_at  = hash[:created_at]
    @updated_at  = hash[:updated_at]
    @parent      = hash[:parent]
  end

  def unit_price_to_dollars
    BigDecimal.new(@unit_price).round(2)
  end

  def merchant
    @parent.parent.merchants.find_by_id(@merchant_id)
  end
end
