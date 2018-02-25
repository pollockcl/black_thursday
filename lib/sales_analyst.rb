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

  def invoice_items
    @sales_engine.invoice_items.all
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
    data = invoices.select { |invoice| invoice.status == status }.size
    ((data.to_f / invoices.size) * 100).round(2)
  end

  def total_revenue_by_date(date)
    data = invoices.select { |invoice| invoice.created_at == date }
    data.map(&:total).reduce(:+)
  end

  def merchants_ranked_by_revenue
    merchants.sort_by do |merchant|
      merchant.invoices.map(&:total).reduce(:+)
    end.reverse
  end

  def top_revenue_earners(size = 20)
    merchants_ranked_by_revenue[0...size]
  end

  def merchants_with_pending_invoices
    merchants.select do |merchant|
      merchant.invoices.map(&:is_paid_in_full?).include?(false)
    end
  end

  def most_sold_item_for_merchant(merch_id)
    merchant = @sales_engine.merchants.find_by_id(merch_id)
    items = merchant.all_items_by_quantity
    max_quantity = merchant.sales_quantities[items.last.id]
    items.select { |item| merchant.sales_quantities[item.id] == max_quantity }
  end
  # def merchant_invoice_items(merch_id)
  #   @sales_engine.invoices.find_all_by_merchant_id(merch_id).map do |invoice|
  #     invoice_items.select { |ii| ii.invoice_id == invoice.id }
  #   end.flatten
  # end

  # def quantities_by_merchant(merch_id)
  #   totals = Hash.new(0)
  #   merchant_invoice_items(merch_id).each { |ii| totals[ii.item_id] += ii.quantity }
  #   totals
  # end

  # def merchant_items_by_quantity(merch_id)
  #   merch_items = merchant_invoice_items(merch_id).map do |ii|
  #     items.select { |item| item.id == ii.item_id }
  #   end.flatten
  #   merch_items.sort_by do |item|
  #     merchant_item_quantities[item.id]
  #   end
  # end

  # def most_sold_item_for_merchant(merch_id)
  #   merchant = @sales_engine.merchants.find_by_id(merch_id)
  #   items = merchant.items_sold
  #   max_quantity = merchant.sales_quantities[items.last.id]
  #   items.select { |item| merchant.sales_quantities[item.id] == max_quantity }
  # end

  # def item_quantities
  #   totals = Hash.new(0)
  #   invoice_items.each { |ii| totals[ii.item_id] += ii.quantity }
  #   totals
  # end
  #
  # def merchant_items_by_quantity(merch_id)
  #   @sales_engine.items.find_all_by_merchant_id(merch_id).sort_by do |item|
  #     item_quantities[item.id]
  #   end
  # end
  #
  # def most_sold_item_for_merchant(merch_id)
  #   items = merchant_items_by_quantity(merch_id)
  #   top_quantity = item_quantities[items.last.id]
  #   items.select { |item| item_quantities[item.id] == top_quantity }
  # end
end
