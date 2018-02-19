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
    average(items.size, merchants.size).to_f.round(2)
  end

  def average_items_per_merchant_standard_deviation
    data = merchants.map { |merch| merch.items.size }
    standard_deviation(data, average_items_per_merchant).round(2)
  end

  def merchants_with_high_item_count
    std_deviation = average_items_per_merchant_standard_deviation
    avg           = average_items_per_merchant
    merchants.select do |merchant|
      data = merchant.items.size
      z_score(avg, std_deviation, data) > 1
    end
  end

  def average_item_price_for_merchant(merchant_id)
    inventory = @sales_engine.merchants.find_by_id(merchant_id).items
    prices    = inventory.map(&:unit_price)
    average(prices.reduce(:+), inventory.size)
  end

  def average_average_price_per_merchant
    numerator = merchants.reduce(0) do |sum, merchant|
      sum + average_item_price_for_merchant(merchant.id)
    end
    average(numerator, merchants.size)
  end

  def average_item_price
    numerator = items.map { |item| item.unit_price.to_i }.reduce(:+)
    average(numerator, items.size)
  end

  def average_item_price_standard_deviation
    data = items.map { |item| item.unit_price.to_i }
    avg  = average_item_price
    standard_deviation(data, avg)
  end

  def golden_items
    std_deviation = average_item_price_standard_deviation
    avg           = average_item_price
    items.select do |item|
      data = item.unit_price.to_i
      z_score(avg, std_deviation, data) > 2
    end
  end
end
