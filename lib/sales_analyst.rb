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

  def average_average_price_per_merchant
    total = merchants.reduce(0) do |total, merchant|
      total + average_item_price_for_merchant(merchant.id)
    end
    average(total, merchants.size)
  end

  def golden_items
    avg   = average_average_price_per_merchant
    range = merchants.map { |merchant| average_item_price_for_merchant(merchant.id) }
    std_deviation = standard_deviation(range, avg)
    merchants.select{ |merchant| ((merchant.items.unit_price - avg) / std_deviation) > 2 }
  end
end
