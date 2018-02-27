require_relative 'arithmetic'
require_relative 'merchant_analyst'
require_relative 'item_analyst'
require_relative 'invoice_analyst'
require 'bigdecimal'
# This is the SalesAnalyst class
class SalesAnalyst
  include Arithmetic
  include MerchantAnalyst
  include ItemAnalyst
  include InvoiceAnalyst
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

  def invoices
    @sales_engine.invoices.all
  end

  def invoice_items
    @sales_engine.invoice_items.all
  end

  def total_revenue_by_date(date)
    data = invoices.select { |invoice| invoice.created_at == date }
    data.map(&:total).reduce(:+)
  end
end
