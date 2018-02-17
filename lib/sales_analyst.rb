# This is the SalesAnalyst class
class SalesAnalyst
  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    @sales_engine.items.all.size / @sales_engine.merchants.all.size
  end
end
