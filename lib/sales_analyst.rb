require_relative 'arithmetic'
require 'bigdecimal'
# This is the SalesAnalyst class
class SalesAnalyst
  include Arithmetic
  attr_reader :standard_deviation_avg_item_price
  def initialize(sales_engine)
    @sales_engine = sales_engine
    @standard_deviation_items = average_items_per_merchant_standard_deviation
    # @standard_deviation_avg_item_price = average_average_item_prices_per_merchant_standard_deviation
  end

  def average_items_per_merchant
    avg_items_per_merchant(@sales_engine).round(2)
  end

  def average_items_per_merchant_standard_deviation
    std_deviation_items_per_merchant(@sales_engine).round(2)
  end

  def merchants_with_high_item_count
    @sales_engine.merchants.all.select do |merchant|
      (merchant.items.size / @standard_deviation_items) > 1
    end
  end

  def average_item_prices_for_merchant(id)
    avg_item_price_for_merchant(@sales_engine, id)
  end

  def average_average_item_prices_per_merchant
    avg_avg_item_prices_per_merchant(@sales_engine).round(2)
  end
  #
  # def average_average_item_prices_per_merchant_standard_deviation
  #   std_deviation_avg_item_prices_per_merchant(@sales_engine)
  # end
  #
  # def golden_items
  #   @sales_engine.items.all.select do |item|
  #     (item.unit_price_to_dollars / @standard_deviation_avg_item_price) > 2
  #   end
  # end
end
