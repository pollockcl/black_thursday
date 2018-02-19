require 'bigdecimal'
# This is the Arithmatic module
module Arithmetic
  def avg_items_per_merchant(sales_engine)
    BigDecimal(sales_engine.items.size) / BigDecimal(sales_engine.merchants.size)
  end

  def sum_diff_means_items_per_merchant_squared(sales_engine)
    sales_engine.merchants.all.map do |merchant|
      (merchant.items.size - avg_items_per_merchant(sales_engine))**2
    end.sum
  end

  def variance_items_per_merchant(sales_engine)
    sum_diff_means_items_per_merchant_squared(sales_engine) /\
      (sales_engine.merchants.size - 1)
  end

  def std_deviation_items_per_merchant(sales_engine)
    Math.sqrt(variance_items_per_merchant(sales_engine))
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
    sum_unit_prices_for_merchant(sales_engine, id) / \
      total_units_for_merchant(sales_engine, id)
  end

  # def sum_avg_item_prices_all_merchants(sales_engine)
  #   sales_engine.merchants.all.reduce(BigDecimal.new(0)) do |sum, merchant|
  #     sum += avg_item_price_for_merchant(sales_engine, merchant.id)
  #   end
  # end

  # def avg_avg_item_prices_per_merchant(sales_engine)
  #   sum_avg_item_prices_all_merchants(sales_engine) / \
  #     sales_engine.merchants.size
  # end
  #
  # def sum_diff_means_avg_item_prices_per_merchant_squared(sales_engine)
  #   sales_engine.merchants.all.map do |merchant|
  #     (avg_item_price_for_merchant(sales_engine, merchant.id) -
  #       avg_avg_item_prices_per_merchant(sales_engine))**2
  #   end.sum
  # end
  #
  # def variance_avg_item_prices_per_merchant(sales_engine)
  #   sum_diff_means_avg_item_prices_per_merchant_squared(sales_engine) / \
  #     (sales_engine.merchants.size - 1)
  # end
  #
  # def std_deviation_avg_item_prices_per_merchant(sales_engine)
  #   Math.sqrt(variance_avg_item_prices_per_merchant(sales_engine))
  # end
end
