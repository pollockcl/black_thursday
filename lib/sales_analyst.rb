require_relative 'arithmetic'
require 'bigdecimal'
# This is the SalesAnalyst class
class SalesAnalyst
  include Arithmetic
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

  def average_item_price_for_merchant(id)
    avg_item_price_for_merchant(@sales_engine, id)
  end

  def average_average_price_per_merchant
    sum_average_item_price_all_merchants(@sales_engine) / @sales_engine.merchants.all.size
  end
end
