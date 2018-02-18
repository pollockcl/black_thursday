require_relative 'arithmatic'
require 'bigdecimal'
# This is the SalesAnalyst class
class SalesAnalyst
  include Arithmatic
  def initialize(sales_engine)
    @sales_engine = sales_engine
    @standard_deviation_items = average_items_per_merchant_standard_deviation
  end

  def average_items_per_merchant
    average(@sales_engine)
  end

  def average_items_per_merchant_standard_deviation
    standard_deviation(@sales_engine).round(2)
  end

  def merchants_with_high_item_count
    @sales_engine.merchants.all.select do |merchant|
      (merchant.items.size / @standard_deviation_items) > 1
    end
  end

  def total_units_for_merchant(id)
    BigDecimal(@sales_engine.items.find_all_by_merchant_id(id).size)
  end

  def sum_unit_prices_for_merchant(id)
    @sales_engine.items.find_all_by_merchant_id(id).reduce(BigDecimal.new(0)) do |sum, item|
      sum += item.unit_price_to_dollars
    end
  end

  def average_item_price_for_merchant(id)
    sum_unit_prices_for_merchant(id) / total_units_for_merchant(id)
  end
end
