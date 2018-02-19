# This is the Item class
class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :merchant_id,
              :created_at,
              :updated_at
  def initialize(attributes)
    @id          = attributes[:id].to_i
    @name        = attributes[:name]
    @description = attributes[:description]
    @unit_price  = attributes[:unit_price]
    @merchant_id = attributes[:merchant_id].to_i
    @created_at  = attributes[:created_at]
    @updated_at  = attributes[:updated_at]
    @parent      = attributes[:parent]
  end

  def unit_price_to_dollars
    BigDecimal.new(@unit_price).round(2)
  end

  def merchant
    @parent.parent.merchants.find_by_id(@merchant_id)
  end
end
