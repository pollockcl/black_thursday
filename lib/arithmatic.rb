# This is the Arithmatic module
module Arithmatic
  def average(sales_engine)
    sales_engine.items.size / sales_engine.merchants.size
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
end
