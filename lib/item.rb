# This is the Item class
class Item
  attr_reader :id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at, :parent
  def initialize(id, name, description, unit_price, merchant_id, created_at, updated_at, parent)
    @id          = id
    @name        = name
    @description = description
    @unit_price  = unit_price
    @merchant_id = merchant_id
    @created_at  = created_at
    @updated_at  = updated_at
    @parent      = parent
  end

  def unit_price_to_dollars
    BigDecimal.new(@unit_price).round(2)
  end

  def merchant
    @parent.parent.merchants.find_by_id(@merchant_id)
  end
end
