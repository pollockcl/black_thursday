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
    @sales_engine.items.size
  end

  def merchants
    @sales_engine.merchants.size
  end

  def average_items_per_merchant
    average(items, merchants)
  end
end
