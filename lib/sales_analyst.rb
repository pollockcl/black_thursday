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

  def invoices
    @sales_engine.invoices.all
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
      z_score(data, avg, std_deviation) > 1
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
    standard_deviation(data, average_item_price)
  end

  def golden_items
    std_deviation = average_item_price_standard_deviation
    items.select do |item|
      data = item.unit_price.to_i
      z_score(data, average_item_price, std_deviation) > 2
    end
  end

  def average_invoices_per_merchant
    average(invoices.size, merchants.size).to_f
  end

  def net_invoices(merchant_id)
    @sales_engine.invoices.find_all_by_merchant_id(merchant_id).size
  end

  def average_invoices_per_merchant_standard_deviation
    data = merchants.map { |merchant| net_invoices(merchant.id) }
    standard_deviation(data, average_invoices_per_merchant).round(2)
  end

  def top_merchants_by_invoice_count
    std_deviation = average_invoices_per_merchant_standard_deviation
    avg           = average_invoices_per_merchant
    merchants.select do |merchant|
      data = net_invoices(merchant.id)
      z_score(data, avg, std_deviation) > 2
    end
  end

  def bottom_merchants_by_invoice_count
    std_deviation = average_invoices_per_merchant_standard_deviation
    merchants.select do |merchant|
      data = net_invoices(merchant.id)
      z_score(data, average_invoices_per_merchant, std_deviation) < -2
    end
  end

  def average_daily_invoices
    average(invoices.size, 7)
  end

  def find_days
    data = invoices.group_by(&:weekday_created)
    data.each_key { |day| data[day] = data[day].size }
  end

  def std_deviation_daily_invoices
    standard_deviation(find_days.invert, average_daily_invoices)
  end

  def top_days_by_invoice_count
    find_days.select do |_k, invoice|
      z_score(invoice, average_daily_invoices, std_deviation_daily_invoices) > 1
    end.keys
  end

  def invoice_status(status)
    data = invoices.select { |invoice| invoice.status.to_s == status }.size
    ((data.to_f / invoices.size) * 100).round(2)
  end

  def total_revenue_by_date(date)
    data = invoices.select { |invoice| invoice.created_at == Time.parse(date) }
    data.map(&:total).reduce(:+)
  end

  def top_revenue_earners(size = 20)
    merchants.sort_by do |merchant|
      # require "pry"; binding.pry
      invs = invoices.select { |invoice| invoice.merchant_id == merchant.id }
      invs.map(&:total).reduce(:+)
    end[-size..-1]
  end
end
