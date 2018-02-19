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
    (Math.sqrt(merchants.map do |merchant|
      (merchant.items.size - average_items_per_merchant)**2
    end.sum / merchants.size)).round(2)
  end
end
