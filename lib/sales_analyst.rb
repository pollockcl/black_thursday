require_relative 'arithmatic'
# This is the SalesAnalyst class
class SalesAnalyst
  include Arithmatic
  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    average(@sales_engine)
  end

  def average_items_per_merchant_standard_deviation
    standard_deviation(@sales_engine).round(2)
  end
end
