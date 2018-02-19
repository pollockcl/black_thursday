require_relative 'arithmetic'
require 'bigdecimal'
# This is the SalesAnalyst class
class SalesAnalyst
  include Arithmetic
  attr_reader :standard_deviation_avg_item_price
  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def items
    @sales_engine.items.all
  end

  def merchants
    @sales_engine.merchants.all
  end

  def average_items_per_merchant
    average(items.size, merchants.size)
  end

  def average_items_per_merchant_standard_deviation
    standard_deviation(merchants, average_items_per_merchant)
  end

  def merchants_with_high_item_count
    std_deviation = average_items_per_merchant_standard_deviation
    avg           = average_items_per_merchant
    merchants.select do |merchant|
      ((merchant.items.size - avg) / std_deviation) > 1
    end
  end

  def average_item_price_for_merchant(merchant_id)
    inventory = @sales_engine.merchants.find_by_id(merchant_id).items
    prices    = inventory.map { |item| item.unit_price.to_i }
    average(prices.sum, inventory.size)
  end
end
