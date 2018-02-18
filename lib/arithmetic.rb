require 'bigdecimal'
# This is the Arithmatic module
module Arithmetic
  def average(sales_engine)
    (sales_engine.items.size / sales_engine.merchants.size).to_f
  end

  def mean_diff_squared(sales_engine)
    sales_engine.merchants.all.map do |merchant|
      (merchant.items.size - average_items_per_merchant)**2
    end.sum
  end

  def variance(sales_engine)
    mean_diff_squared(sales_engine) / (sales_engine.merchants.size - 1)
  end

  def standard_deviation(sales_engine)
    Math.sqrt(variance(sales_engine))
  end

  def total_units_for_merchant(sales_engine, id)
    BigDecimal(sales_engine.items.find_all_by_merchant_id(id).size)
  end

  def sum_unit_prices_for_merchant(sales_engine, id)
    sales_engine.items.find_all_by_merchant_id(id).reduce(BigDecimal.new(0)) do |sum, item|
      sum += item.unit_price_to_dollars
    end
  end

  # moved core formula here because of the need to carry out division over two lines
  def avg_item_price_for_merchant(sales_engine, id)
    sum_unit_prices_for_merchant(sales_engine, id) /\
      total_units_for_merchant(sales_engine, id)
  end

  def sum_average_item_price_all_merchants(sales_engine)
    sales_engine.merchants.all.reduce(BigDecimal.new(0)) do |sum, merchant|
      sum += average_item_price_for_merchant(merchant.id)
    end
  end

# moved core formula here because of the need to carry out division over two lines
  def avg_avg_price_per_merchant(sales_engine)
    sum_average_item_price_all_merchants(sales_engine) /\
      sales_engine.merchants.all.size
  end
end
